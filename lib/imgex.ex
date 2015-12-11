defmodule Imgex do
  @moduledoc """
  Provides functions to generate secure imgix URLs.
  """

  def token, do: Application.get_env(:imgex, :secure_token)
  def domain, do: Application.get_env(:imgex, :imgix_domain)

  @doc """
  Generates a secure imgix URL given the full public URL and optional imgix
  parameters.
  """
  def web_proxy(path, params \\ nil) do

    # URI-encode the public URL.
    path =  "/" <> URI.encode(path, &URI.char_unreserved?/1)

    # Add query parameters to the path.
    if params !== nil do
      path = path <> "?" <> URI.encode_query(params)
    end

    # Use a md5 hash of the path and secret token as a signature.
    signature = Base.encode16(:erlang.md5(token <> path), case: :lower)

    # Append the signature to verify the request is valid.
    if params !== nil do
      domain <> path <> "&s=" <> signature
    else
      domain <> path <> "?s=" <> signature
    end

  end

end
