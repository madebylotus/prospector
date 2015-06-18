module Prospector
  class Configuration
    attr_writer :secret_token, :client_secret

    def secret_token
      @secret_token || ENV['PROSPECTOR_SECRET_TOKEN'] || raise(InvalidCredentialsError)
    end

    def client_secret
      @client_secret || ENV['PROSPECTOR_CLIENT_SECRET'] || raise(InvalidCredentialsError)
    end
  end
end
