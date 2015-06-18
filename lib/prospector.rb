require "json"
require "bundler"
require "prospector/version"

require "prospector/client"
require "prospector/configuration"
require "prospector/error"

begin
  require "pry"
rescue LoadError
end

module Prospector
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.notify!
    specifications = Bundler.environment.specs

    Client.deliver(specifications)
  end
end
