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
  config.background_adapter = :sidekiq

  config.enabled = Rails.env.production?
end
```

## Usage

### Rails

When the gem is included into a Rails project, you have the option of specifying a background adapter to run the notification service asynchronously on.  The default adapter is `ActiveJob` if available in your Rails project, but we also support `Sidekiq` at this time.

You can choose to enable Prospector in the initializer file, or by the presence of an ENV variable "PROSPECTOR_ENABLED" as shown below.

```ruby
# set the ENV variable
# ENV['PROSPECTOR_ENABLED'] = 'true'
# or
Prospector.configure do |config|
  config.enabled = Rails.env.production?
end
```

### Without Rails

Without Rails, you need to manually call the method to notify the Prospector service yourself.

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
