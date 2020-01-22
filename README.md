<!-- ix-docs-ignore -->
# imgex
> Unofficial client library for generating imgix URLs in Elixir

[![Hex version][hexImage]][hexUrl]
[![CI][ciImage]][ciUrl]
<!-- /ix-docs-ignore -->

- [Installation](#installation)
- [Documentation](#documentation)
- [Configuration](#configuration)
- [Usage](#usage)

## Installation

imgex is [available in Hex](https://hex.pm/packages/imgex), the package can be
installed as:

  1. Add imgex to your list of dependencies in `mix.exs`:

     ```elixir
     def deps do
       [{:imgex, "~> 0.2.0"}]
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

To use the library you have to configure your imgix domain and secure token or
pass them as an options map `%{domain: "domain", token: "token"}` as the
third parameter to `Imgex.url/3` or `Imgex.proxy_url/3`.
See `config/test.exs` for an example of how to configure this.

## Usage

To generate an imgix url based on a path (Web Folder and S3 sources) and
optional parameters do:

```elixir
url = Imgex.url "/images/cats.jpg", %{w: 700}
```

To generate an imgix url based on a public URL (Web Proxy sources) and optional
parameters do:

```elixir
url = Imgex.proxy_url "https://some-public-url.com/cats.jpg", %{w: 700}
```

&nbsp;

Created by [Ian Walter](https://ianwalter.dev)

[hexImage]: https://img.shields.io/hexpm/v/imgex.svg
[hexUrl]: https://hex.pm/packages/imgex
[ciImage]: https://github.com/ianwalter/imgex/workflows/CI/badge.svg
[ciUrl]: https://github.com/ianwalter/imgex/actions
