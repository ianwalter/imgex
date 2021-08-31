defmodule Imgex do
  @moduledoc """
  Provides functions to generate secure Imgix URLs.
  """

  @doc """
  Provides configured source information when it's not passed explicitly to
  `url/3` or `proxy_url/3`.
  """
  def configured_source,
    do: %{
      token: Application.get_env(:imgex, :secure_token),
      domain: Application.get_env(:imgex, :imgix_domain)
    }

  @doc """
  Generates a secure Imgix URL from a Web Proxy source given:
  * `path` - The full public image URL.
  * `params` - (optional) A map containing Imgix API parameters used to manipulate the image.
  * `source` - (optional) A map containing Imgix source information:
      * `:token` - The secure token used to sign API requests.
      * `:domain` - The Imgix source domain.

  ## Examples

      iex> Imgex.proxy_url "http://avatars.com/john-smith.png"
      "https://my-social-network.imgix.net/http%3A%2F%2Favatars.com%2Fjohn-smith.png?s=493a52f008c91416351f8b33d4883135"
      iex> Imgex.proxy_url "http://avatars.com/john-smith.png", %{w: 400, h: 300}
      "https://my-social-network.imgix.net/http%3A%2F%2Favatars.com%2Fjohn-smith.png?h=300&w=400&s=a201fe1a3caef4944dcb40f6ce99e746"

  """
  def proxy_url(path, params \\ %{}, source \\ configured_source()) when is_map(params) do
    # URI-encode the public URL.
    path = "/" <> URI.encode(path, &URI.char_unreserved?/1)

    # Return the generated URL.
    url(path, params, source)
  end

  @doc """
  Generates custom `srcset` attributes for Imgix URLs, pre-signed with the
  source's secure token (if configured). These are useful for responsive
  images at a variety of screen sizes or pixel densities.

  By default, the `srcset` generated will allow for responsive size switching
  by building a list of image-width mappings. This default list of image
  width mappings covers a wide range of 31 different widths from 100px to
  8192px. This default results in quite a long `srcset` attribute, though, so
  it is preferable to instead give more specific size guidance by specifying
  either:

  * a width, _OR_
  * a height + aspect ratio

  When these params are provided, the returned `srcset` will cover 5
  different pixel densities (1x-5x).

  ## Arguments

  * `path` - The URL path to the image.
  * `params` - (optional) A map containing Imgix API parameters used to manipulate the image.
  * `source` - (optional) A map containing Imgix source information:
      * `:token` - The secure token used to sign API requests.
      * `:domain` - The Imgix source domain.

  ## Examples

      iex> Imgex.srcset("/images/lulu.jpg", %{w: 100})
      "https://my-social-network.imgix.net/images/lulu.jpg?dpr=1&w=100&s=9bd210f344a0f65032951a9cf171c40e 1x,
      https://my-social-network.imgix.net/images/lulu.jpg?dpr=2&w=100&s=33520b8f84fa72afa28539d66fb2734f 2x,
      https://my-social-network.imgix.net/images/lulu.jpg?dpr=3&w=100&s=97d0f1731b4c8d8dd609424dfca2eab5 3x,
      https://my-social-network.imgix.net/images/lulu.jpg?dpr=4&w=100&s=b96a02e08eeb50df5a75223c998e46f5 4x,
      https://my-social-network.imgix.net/images/lulu.jpg?dpr=5&w=100&s=9ba1ab37db9f09283d9194223fbafb2f 5x"
      iex> Imgex.srcset("/images/lulu.jpg", %{ar: "3:4", h: 500})
      "https://my-social-network.imgix.net/images/lulu.jpg?ar=3%3A4&dpr=1&h=500&s=fa2016a84454271a30c00c93a6d236a2 1x,
      https://my-social-network.imgix.net/images/lulu.jpg?ar=3%3A4&dpr=2&h=500&s=43303719ce9a76e618c6d16ef7b5f30f 2x,
      https://my-social-network.imgix.net/images/lulu.jpg?ar=3%3A4&dpr=3&h=500&s=b1f39589cf13b10a7480c4b90f4dcea4 3x,
      https://my-social-network.imgix.net/images/lulu.jpg?ar=3%3A4&dpr=4&h=500&s=1be6ccb379a227b8e4cfa8ebcbca2b76 4x,
      https://my-social-network.imgix.net/images/lulu.jpg?ar=3%3A4&dpr=5&h=500&s=455776036fb49c420f20d93fb59af96e 5x"

  """
  def srcset(
        path,
        params \\ %{},
        source \\ configured_source()
      )
      when is_map(params) do
    width = params[:w]
    height = params[:h]
    aspect_ratio = params[:ar]

    if width || (height && aspect_ratio) do
      build_dpr_srcset(path, params, source)
    else
      build_srcset_pairs(path, params, source)
    end
  end

  @doc """
  Generates a secure Imgix URL given:
  * `path` - The URL path to the image.
  * `params` - (optional) A map containing Imgix API parameters used to manipulate the image.
  * `source` - (optional) A map containing Imgix source information:
      * `:token` - The secure token used to sign API requests.
      * `:domain` - The Imgix source domain.

  ## Examples

      iex> Imgex.url "/images/jets.png"
      "https://my-social-network.imgix.net/images/jets.png?s=7c6a3ef8679f4965f5aaecb66547fa61"
      iex> Imgex.url "/images/jets.png", %{con: 10}, %{domain: "https://cannonball.imgix.net", token: "xxx187xxx"}
      "https://cannonball.imgix.net/images/jets.png?con=10&s=d982f04bbca4d819971496524aa5f95a"

  """
  def url(path, params \\ %{}, source \\ configured_source()) when is_map(params) do
    # Add query parameters to the path.
    path = path_with_params(path, params)

    # Use a md5 hash of the path and secret token as a signature.
    signature = Base.encode16(:erlang.md5(source.token <> path), case: :lower)

    # Append the signature to verify the request is valid and return the URL.
    if params == %{} do
      source.domain <> path <> "?s=" <> signature
    else
      source.domain <> path <> "&s=" <> signature
    end
  end

  defp path_with_params(path, params) when params == %{}, do: path

  defp path_with_params(path, params) when is_map(params) do
    path <> "?" <> URI.encode_query(params)
  end

  # Default set of target widths, borrowed from JS and Ruby Imgix libraries.
  @default_srcset_target_widths [
    100,
    116,
    134,
    156,
    182,
    210,
    244,
    282,
    328,
    380,
    442,
    512,
    594,
    688,
    798,
    926,
    1074,
    1246,
    1446,
    1678,
    1946,
    2258,
    2618,
    3038,
    3524,
    4088,
    4742,
    5500,
    6380,
    7400,
    8192
  ]

  @default_srcset_target_ratios [1, 2, 3, 4, 5]

  defp build_srcset_pairs(path, params, source) when is_map(params) do
    @default_srcset_target_widths
    |> Enum.map(fn width ->
      updated_params = Map.put(params, :w, width)
      url(path, updated_params, source) <> " #{width}w"
    end)
    |> Enum.join(",\n")
  end

  defp build_dpr_srcset(path, params, source) when is_map(params) do
    Enum.map(@default_srcset_target_ratios, fn ratio ->
      updated_params = Map.put(params, :dpr, ratio)
      url(path, updated_params, source) <> " #{ratio}x"
    end)
    |> Enum.join(",\n")
  end
end
