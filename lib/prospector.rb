require "json"
require "bundler"
require "prospector/version"

require "prospector/client"
require "prospector/configuration"
require "prospector/error"

require "prospector/railtie" if defined?(Rails)

begin
  require "pry"
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
      configuration.notify!

      specifications = Bundler.environment.specs

      Client.deliver(specifications)
    end
  end

  extend ClassMethods
end
