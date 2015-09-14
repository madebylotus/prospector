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

Projects can be configured via environment variables, a code block, or a RubyMotion configuration.

### Environment Variables

```sh
export PROSPECTOR_ENABLED=true
export PROSPECTOR_SECRET_TOKEN=token
export PROSPECTOR_CLIENT_SECRET=secret
export PROSPECTOR_BACKGROUND_ADAPTER=sidekiq
```

### Code Block

```ruby
Prospector.configure do |config|
  config.secret_token = 'token from service'
  config.client_secret = 'secret from service'
  config.background_adapter = :sidekiq

  config.enabled = Rails.env.production?
end
```

### RubyMotion

A common configuration for a RubyMotion project follows, enabling only for release builds.

```ruby
Motion::Project::App.setup do |app|
  app.prospector do |config|
    config.secret_token = 'token from service'
    config.client_secret = 'secret from service'
  end

  app.release do
    app.prospector do |config|
      config.enabled = true
    end
  end
end
```

## Usage

### Rails

Rails integration includes automatic detection and support for ActiveJob as well as Sidekiq, to deliver usage details to the Prospector API in the background on app boot.  Additionally, the rake task mentioned below is available to use at any time you see fit, for example as part of your deployment process.

Valid background adapter options are `active_job`, `sidekiq`, and `none`.  ActiveJob is preferred and chosen in Rais 4.2 and above with built-in ActiveJob support.

### Rake Task

If you prefer to notify the Prospector service at any other time, you can use the included Rake task.

```
rake prospector:deliver
```

### Manually

If you prefer to notify the Prospector API without using the included Rails or RubyMotion support, you can always call directly.

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
