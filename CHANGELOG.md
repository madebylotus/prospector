# Prospector Changelog

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