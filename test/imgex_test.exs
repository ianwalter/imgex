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

  test "url/3 without token generates unsigned url" do
    assert Imgex.url("/images/jets.png", %{}, %{token: nil}) ==
             "https://my-social-network.imgix.net/images/jets.png"
  end

  describe "srcset/3" do
    @default_srcset_widths ~w(
      100 116 134 156 182 210 244 282 328 380 442 512 594 688 798 926 1074
      1246 1446 1678 1946 2258 2618 3038 3524 4088 4742 5500 6380 7400 8192
    ) |> Enum.map(&Integer.parse/1) |> Enum.map(fn {val, ""} -> val end)

    test "by default, generates 31 width pairs" do
      path = "/images/lulu.jpg"
      srcset = Imgex.srcset(path)
      split = String.split(srcset, ",\n")
      assert length(split) == 31

      @default_srcset_widths
      |> Enum.with_index()
      |> Enum.each(fn {width, i} ->
        src = Enum.at(split, i)
        assert src == "#{Imgex.url(path, %{w: width})} #{width}w"
      end)
    end

    test "with only a height, generates 31 width pairs" do
      path = "/images/lulu.jpg"

      srcset = Imgex.srcset(path, %{h: 100})
      split = String.split(srcset, ",\n")
      assert length(split) == 31

      @default_srcset_widths
      |> Enum.with_index()
      |> Enum.each(fn {width, i} ->
        src = Enum.at(split, i)
        assert src == "#{Imgex.url(path, %{h: 100, w: width})} #{width}w"
      end)
    end

    test "with a height and aspect ratio, generates 5 dpr pairs" do
      path = "/images/lulu.jpg"
      srcset = Imgex.srcset(path, %{ar: "3:4", h: 100})
      split = String.split(srcset, ",\n")
      assert length(split) == 5

      [1, 2, 3, 4, 5]
      |> Enum.each(fn dpr ->
        src = Enum.at(split, dpr - 1)
        assert src == "#{Imgex.url(path, %{ar: "3:4", dpr: dpr, h: 100})} #{dpr}x"
      end)
    end

    test "with a height, aspect ratio, and other params, generates 5 dpr pairs" do
      path = "/images/lulu.jpg"
      params = %{ar: "3:4", crop: "faces,entropy,left", h: 100}
      srcset = Imgex.srcset(path, params)
      split = String.split(srcset, ",\n")
      assert length(split) == 5

      [1, 2, 3, 4, 5]
      |> Enum.each(fn dpr ->
        src = Enum.at(split, dpr - 1)
        assert src == "#{Imgex.url(path, Map.put(params, :dpr, dpr))} #{dpr}x"
      end)
    end

    test "with only a width, generates 5 dpr pairs" do
      path = "/images/lulu.jpg"
      srcset = Imgex.srcset(path, %{w: 100})
      split = String.split(srcset, ",\n")
      assert length(split) == 5

      [1, 2, 3, 4, 5]
      |> Enum.each(fn dpr ->
        src = Enum.at(split, dpr - 1)
        assert src == "#{Imgex.url(path, %{dpr: dpr, w: 100})} #{dpr}x"
      end)
    end
  end
end
