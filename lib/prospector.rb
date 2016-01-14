require "json"
require "bundler"
require "net/http"

require "prospector/version"

require "prospector/ruby_version"
require "prospector/client"
require "prospector/configuration"
require "prospector/error"
require "prospector/background"
require "prospector/tasks"

require "prospector/railtie" if defined?(Rails)
require "prospector/motion/config" if defined?(Motion::Project::Config)

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

    def ruby_version
      @ruby_version ||= RubyVersion.new
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
