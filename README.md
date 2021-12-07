<!-- ix-docs-ignore -->
# imgex
> An Elixir client library for generating image URLs with imgix

[![CI](https://github.com/ianwalter/imgex/actions/workflows/ci.yml/badge.svg)](https://github.com/ianwalter/imgex/actions/workflows/ci.yml)
[![Module Version](https://img.shields.io/hexpm/v/imgex.svg)](https://hex.pm/packages/imgex)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/imgex/)
[![Total Download](https://img.shields.io/hexpm/dt/imgex.svg)](https://hex.pm/packages/imgex)
[![License](https://img.shields.io/hexpm/l/imgex.svg)](https://github.com/ianwalter/imgex/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/ianwalter/imgex.svg)](https://github.com/ianwalter/imgex/commits/master)

<!-- /ix-docs-ignore -->

- [Installation](#installation)
- [Documentation](#documentation)
- [Configuration](#configuration)
- [Usage](#usage)

## Installation

imgex is [available in Hex](https://hex.pm/packages/imgex), the package can be
installed as:

Add `:imgex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:imgex, "~> 0.2.0"},
  ]
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

To generate an imgix URL based on a path (Web Folder and S3 sources) and
optional parameters do:

```elixir
url = Imgex.url "/images/cats.jpg", %{w: 700}
```

To generate an imgix URL based on a public URL (Web Proxy sources) and optional
parameters do:

```elixir
url = Imgex.proxy_url "https://some-public-url.com/cats.jpg", %{w: 700}
```

## Copyright and License

Copyright (c) 2019 [Ian Walter](https://ianwalter.dev)

This work is free. You can redistribute it and/or modify it under the
terms of the ISC License. See the [LICENSE.md](./LICENSE.md) file for more details.
