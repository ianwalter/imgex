# Changes to imgex

## Pending changes

* Support sending in an empty map as params

Breaking Changes:
* `Imgex.proxy_url/3` and `Imgex.url/3` no longer support params with value `nil`. Instead either don't pass the argument or pass in an empty map (`%{}`)

## v0.1.1
* [#4: Extract path generation to remove Elixir 1.3 warning](https://github.com/ianwalter/imgex/issues/4)
* [#5: Fix Elixir 1.4 missing parentheses warnings](https://github.com/ianwalter/imgex/issues/5)

## v0.1.0
* [#1: Add functions to generate URLs from other sources.](https://github.com/ianwalter/imgex/issues/1)
