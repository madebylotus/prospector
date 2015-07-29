module Prospector
  class RackApp
    def initialize(app)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)

      notify_once if Prospector.enabled?

      @app.call(env)
    end

    private

    def notify_once
      return if notified?

      notify_with_logging
    end

    def notified?
      Prospector.configuration.notified?
    end

    def notify_with_logging
      Rails.logger.debug('[Prospector] Began notifying  API')

      begin
        Prospector.notify!
      rescue InvalidCredentialsError => e
        Rails.logger.error('[Prospector] Please provide credentials to use this service.')
      rescue AccountSubscriptionStatusError => e
        Rails.logger.error("[Prospector] #{ e.message }")
      rescue AuthenticationError => e
        Rails.logger.error("[Prospector] Your account credentials to the API are invalid.")
      rescue UnknownError => e
        Rails.logger.error("[Prospector] There was an unkown error processing your request.")
      ensure
        Rails.logger.debug('[Prospector] Finished notifying API')
      end
    end
  end
end
