# imgex
> Unofficial client library for generating imgix URLs in Elixir

[![Hex version][hex-image]][hex-url]
[![Build status][build-image]][build-url]

## Installation

imgex is [available in Hex](https://hex.pm/packages/imgex), the package can be
installed as:

  1. Add imgex to your list of dependencies in `mix.exs`:

    ```elixir
      def deps do
        [{:imgex, "~> 0.1.0"}]
      end
    ```

  2. Ensure imgex is started before your application:

    ```elixir
      def application do
        [applications: [:imgex]]
      end
    ```

## Documentation

The source is really small so reading through it should be straight-forward but
the full package documentation is available at https://hexdocs.pm/imgex.

## Configuration

To use the library you have to configure your Imgix domain and secure token or
pass them as an options map `%{domain: "domain", token: "token"}` as the
third parameter to `Imgex.url/3` or `Imgex.proxy_url/3`.
See `config/test.exs` for an example of how to configure this.

## Usage

To generate an Imgix url based on a path (Web Folder and S3 sources) and
optional parameters do:

```elixir
url = Imgex.url "/images/cats.jpg", %{w: 700}
```

To generate an Imgix url based on a public URL (Web Proxy sources) and optional
parameters do:

```elixir
url = Imgex.proxy_url "https://some-public-url.com/cats.jpg", %{w: 700}
```

&nbsp;

ISC © [Ian Walter](https://iankwalter.com)

[hex-image]: https://img.shields.io/hexpm/v/imgex.svg
[hex-url]: https://hex.pm/packages/imgex
[build-image]: https://gitlab.recursive.run/ianwalter/imgex/badges/master/pipeline.svg
[build-url]: https://gitlab.recursive.run/ianwalter/imgex/pipelines
