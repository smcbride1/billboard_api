# billboard_api Gem
Gem used to access Billboard charts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'billboard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install billboard

## Usage

Hot 100 list from https://www.billboard.com/charts/hot-100
```ruby
BillboardAPI.hot_100(cache)
```

Artist 100 list from https://www.billboard.com/charts/artist-100
```ruby
BillboardAPI.artist_100(cache)
```

Billboard 200 list from https://www.billboard.com/charts/billboard-200
```ruby
BillboardAPI.billboard_200(cache)
```

When the cache parameter is set to true, a cached response is returned.
By default, requests are not sent for 24 hours after the last request.
The frequency of caching can be adjusted through the setter `cache_frequency`.
```ruby
# 24 hours (defualt)
BillboardAPI.cache_frequency
# => 86400

# 1 hour
BillboardAPI.cache_frequency = 3600
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smcbride1/menu-info.
