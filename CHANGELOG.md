# Changes to imgex

## v0.3.0

* [#8 Add Imgex.srcset to generate srcset pairs](https://github.com/ianwalter/imgex/pull/8)
* [#11 docs: update README for imgix docs](https://github.com/ianwalter/imgex/pull/11)
* [#12 Doc/Readme Updates](https://github.com/ianwalter/imgex/pull/12)

## v0.2.0

* [#6: Changing main repo to gitlab.recursive.run/ianwalter/imgex](https://gitlab.recursive.run/ianwalter/imgex/merge_requests/6)
* [#7: Special-case handling of empty map](https://github.com/ianwalter/imgex/pull/7)

**Breaking Changes:**

* `Imgex.proxy_url/3` and `Imgex.url/3` no longer support params with value
  `nil`. Instead either don't pass the argument or pass in an empty map (`%{}`)

## v0.1.1
* [#4: Extract path generation to remove Elixir 1.3 warning](https://github.com/ianwalter/imgex/issues/4)
* [#5: Fix Elixir 1.4 missing parentheses warnings](https://github.com/ianwalter/imgex/issues/5)

## v0.1.0
* [#1: Add functions to generate URLs from other sources.](https://github.com/ianwalter/imgex/issues/1)
