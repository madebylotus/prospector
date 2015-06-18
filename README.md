# Prospector

Prospector provides a simple integration with the [Gem Prospector](http://www.gemprospector.com) API allowing your team to stay on top of important updates to gems in your Ruby project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prospector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prospector

## Configuration

The access token and secret can be configured either via environment variables, or with an initializer block.

```sh
export PROSPECTOR_SECRET_TOKEN=token
export PROSPECTOR_CLIENT_SECRET=secret
```

or:

```ruby
Prospector.configure do |config|
  config.secret_token = 'token from service'
  config.client_secret = 'secret from service'
end
```

## Usage

Currently the process of notifying the service is not automated.  In the future this will be provided via a rake task as well as a Rails integration.

```ruby
Prospector.notify!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/madebylotus/prospector/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
