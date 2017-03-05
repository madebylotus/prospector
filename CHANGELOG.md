# Prospector Changelog

## Version 1.0.0

* Require Bundler 1.12+ after changes to Bundler's API caused breaking changes [PR #13](https://github.com/madebylotus/prospector/pull/13)

## Version 0.5.0

* Determine ruby version and deliver to API [PR #11](https://github.com/madebylotus/prospector/pull/11)

## Version 0.4.3

* Properly require the "net/http" library

## Version 0.4.2

* Allow easier customization of endpoint and credentials per client instance for development [PR #9](https://github.com/madebylotus/prospector/pull/10)

## Version 0.4.1

* Enhances detection of Rails servers for use with Auto Reporting features [PR #8](https://github.com/madebylotus/prospector/pull/8)

## Version 0.4

* Adds support for an `inline` and `none` background adapter [PR #7](https://github.com/madebylotus/prospector/pull/7)

## Version 0.3

* Adds support for configuring a RubyMotion project [PR #6](https://github.com/madebylotus/prospector/pull/6)
* Adds the `rake prospector:deliver` rake task [PR #6](https://github.com/madebylotus/prospector/pull/6)

## Version 0.2.2

* Skips enqueueing background job to notify API if `Rake` constant is defined

## Version 0.2.1

* Fixes issue with Sidekiq adapter not being recognized [PR #5](https://github.com/madebylotus/prospector/pull/5)

## Version 0.2

* Adds support for enqueueing API notification via ActiveJob or Sidekiq [PR #4](https://github.com/madebylotus/prospector/pull/4)

## Version 0.1.1

* Adds a Rack app to notify API on first request to app server [PR #3](https://github.com/madebylotus/prospector/pull/3)
* Exceptions now raised if trial is expired or account removed from API service [PR #2](https://github.com/madebylotus/prospector/pull/2)

## Version 0.1

Initial alpha release
