defmodule ImgexTest do
  use ExUnit.Case
  doctest Imgex

  test "a web proxy url with no parameters can be generated" do
    url = "https://my-social-network.imgix.net/http%3A%2F%2Favatars.com%2Fjohn-smith.png?s=493a52f008c91416351f8b33d4883135"
    assert url === Imgex.web_proxy("http://avatars.com/john-smith.png")
  end

  test "a web proxy url with parameters can be generated" do
    url = "https://my-social-network.imgix.net/http%3A%2F%2Favatars.com%2Fjohn-smith.png?h=300&w=400&s=a201fe1a3caef4944dcb40f6ce99e746"
    assert url === Imgex.web_proxy(
      "http://avatars.com/john-smith.png",
      %{w: 400, h: 300}
    )
  end
end
