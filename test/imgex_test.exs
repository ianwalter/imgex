defmodule ImgexTest do
  use ExUnit.Case
  doctest Imgex

  test "proxy_url/2 when params are an empty map generates an appropriate url" do
    assert Imgex.proxy_url("http://avatars.com/john-smith.png", %{}) ==
      "https://my-social-network.imgix.net/http%3A%2F%2Favatars.com%2Fjohn-smith.png?s=493a52f008c91416351f8b33d4883135"
  end

  test "url/2 when params are an empty map generates an appropriate url" do
    assert Imgex.url("/images/jets.png", %{}) ==
      "https://my-social-network.imgix.net/images/jets.png?s=7c6a3ef8679f4965f5aaecb66547fa61"
  end
end
