defmodule Imgex do

  @token Application.get_env :imgex, :secure_token
  @domain Application.get_env :imgex, :imgix_domain

  def web_proxy(path, params \\ nil) do
    path =  "/" <> URI.encode(path, &URI.char_unreserved?/1)

    if params !== nil do
      path = path <> "?" <> URI.encode_query(params)
    end

    signature = Base.encode16(:erlang.md5(@token <> path), case: :lower)

    if params !== nil do
      @domain <> path <> "&s=" <> signature
    else
      @domain <> path <> "?s=" <> signature
    end
  end

end
