require "json"
require "bundler"
require "prospector/version"

require "prospector/client"
require "prospector/configuration"
require "prospector/error"
require "prospector/background"
require "prospector/tasks"

require "prospector/railtie" if defined?(Rails)

begin
  require "pry"
  require "sidekiq"
rescue LoadError
end

module Prospector
  class << self
    attr_writer :configuration
  end

  module ClassMethods
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def enabled?
      configuration.enabled?
    end

    def notify!
      raise NotEnabledError unless enabled?

      configuration.notify!

      specifications = Bundler.environment.specs

      Client.deliver(specifications)
    end
  end

  extend ClassMethods
end
