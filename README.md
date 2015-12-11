# imgex [![Hex Version](https://img.shields.io/hexpm/v/imgex.svg)](https://hex.pm/packages/imgex) [![Build Status](https://semaphoreci.com/api/v1/projects/51b06656-01c9-4db2-8794-dfdeb797651a/632439/shields_badge.svg)](https://semaphoreci.com/ianwalter/imgex)

**Unofficial client library for generating imgix URLs in Elixir**

## Installation

imgex is [available in Hex](https://hex.pm/packages/imgex), the package can be
installed as:

  1. Add imgex to your list of dependencies in `mix.exs`:

    ```elixir
      def deps do
        [{:imgex, "~> 0.0.1"}]
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

To use the library you have to configure your imgix domain and secure token.
See `config/test.exs` for an example of how to do this.

## Usage

Right now only a web proxy source is supported because thats all I need. To
generate an imgix url based on a public URL and optional parameter(s) do:

```elixir
url = Imgex.web_proxy "https://some-public-url.com/cats.jpg", %{w: 700}
```
