module Prospector
  class Configuration
    attr_writer :client_secret,
                :enabled,
                :secret_token

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

    def background_adapter
      @background_adapter ||= background_adapter_from_env || determine_default_background_adapater
    end

    def background_adapter=(value)
      @background_adapter = value.to_sym
    end

    def secret_token
      @secret_token || ENV['PROSPECTOR_SECRET_TOKEN'] || raise(InvalidCredentialsError)
    end

    def client_secret
      @client_secret || ENV['PROSPECTOR_CLIENT_SECRET'] || raise(InvalidCredentialsError)
    end

    private

    def background_adapter_from_env
      return if ENV['PROSPECTOR_BACKGROUND_ADAPTER'].nil?

      ENV['PROSPECTOR_BACKGROUND_ADAPTER'].to_sym
    end

    def determine_default_background_adapater
      return :active_job if defined?(ActiveJob)
      return :sidekiq if defined?(Sidekiq)

      :none
    end
  end
end
