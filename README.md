# cxs

`xorshift` Library for Crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  cxs:
    github: moba1/cxs
```

## Usage

```crystal
require "cxs"

p Cxs::XorShift64.new.rand(1..100)
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/moba1/cxs/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [moba1](https://github.com/[your-github-name])  - creator, maintainer
