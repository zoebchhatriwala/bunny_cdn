# BunnyCDN

This gem allows you to interact with the BunnyCDN API. Currently you can interact with the Storage and PullZone APIs.

This does require you to have an account with [BunnyCDN](https://bunnycdn.com/).

## Usage

### Rails

Create the initializer `config/initializers/bunny_cdn.rb` and set the configuration options.

```ruby
BunnyCDN.configure do |config|
    config.apiKey = # The API key for your BunnyCDN account
    config.storageZone = # The storage zone you want to work with
    config.region = # the region of the storage zone. Options are 'eu' for Falkenstein, 'ny' for New York, or 'sg' for Asia
    config.accessKey = # The password for your storage zone
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bunny_cdn. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
