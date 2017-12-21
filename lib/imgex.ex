defmodule Imgex do
  @moduledoc """
  Provides functions to generate secure Imgix URLs.
  """

  @doc """
  Provides configured source information when it's not passed explicitly to
  url/3 or proxy_url/3.
  """
  def configured_source, do: %{
    token: Application.get_env(:imgex, :secure_token),
    domain: Application.get_env(:imgex, :imgix_domain)
  }

  @doc """
  Generates a secure Imgix URL from a Web Proxy source given:
  * `path` - The full public image URL.
  * `params` - (optional) Imgix API parameters used to manipulate the image.
  * `source` - (optional) A map containing Imgix source information:
      * `:token` - The secure token used to sign API requests.
      * `:domain` - The Imgix source domain.

  ## Examples
      iex> Imgex.proxy_url "http://avatars.com/john-smith.png"
      "https://my-social-network.imgix.net/http%3A%2F%2Favatars.com%2Fjohn-smith.png?s=493a52f008c91416351f8b33d4883135"
      iex> Imgex.proxy_url "http://avatars.com/john-smith.png", %{w: 400, h: 300}
      "https://my-social-network.imgix.net/http%3A%2F%2Favatars.com%2Fjohn-smith.png?h=300&w=400&s=a201fe1a3caef4944dcb40f6ce99e746"
  """
  def proxy_url(path, params \\ nil, source \\ configured_source()) do

    # URI-encode the public URL.
    path =  "/" <> URI.encode(path, &URI.char_unreserved?/1)

    # Return the generated URL.
    url path, params, source

  end

  @doc """
  Generates a secure Imgix URL given:
  * `path` - The URL path to the image.
  * `params` - (optional) Imgix API parameters used to manipulate the image.
  * `source` - (optional) A map containing Imgix source information:
      * `:token` - The secure token used to sign API requests.
      * `:domain` - The Imgix source domain.

  ## Examples
      iex> Imgex.url "/images/jets.png"
      "https://my-social-network.imgix.net/images/jets.png?s=7c6a3ef8679f4965f5aaecb66547fa61"
      iex> Imgex.url "/images/jets.png", %{con: 10}, %{domain: "https://cannonball.imgix.net", token: "xxx187xxx"}
      "https://cannonball.imgix.net/images/jets.png?con=10&s=d982f04bbca4d819971496524aa5f95a"
  """
  def url(path, params \\ nil, source \\ configured_source()) do

    # Add query parameters to the path.
    path = path_with_params(path, params)

    # Use a md5 hash of the path and secret token as a signature.
    signature = Base.encode16(:erlang.md5(source.token <> path), case: :lower)

    # Append the signature to verify the request is valid and return the URL.
    if params !== nil do
      source.domain <> path <> "&s=" <> signature
    else
      source.domain <> path <> "?s=" <> signature
    end

  end

  defp path_with_params(path, nil), do: path
  defp path_with_params(path, params) when is_map(params) do
    path <> "?" <> URI.encode_query(params)
  end

end
