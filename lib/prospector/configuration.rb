module Prospector
  class Configuration
    attr_writer :secret_token, :client_secret, :enabled

    def initialize
      @notified = false
    end

    def enabled?
      return @enabled unless @enabled.nil?

      @enabled = ENV['PROSPECTOR_ENABLED'] == 'true'
    end

    def notify!
      @notified = true
    end

    def notified?
      @notified == true
    end

    def secret_token
      @secret_token || ENV['PROSPECTOR_SECRET_TOKEN'] || raise(InvalidCredentialsError)
    end

    def client_secret
      @client_secret || ENV['PROSPECTOR_CLIENT_SECRET'] || raise(InvalidCredentialsError)
    end
  end
end
