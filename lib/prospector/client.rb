module Prospector
  class Client
    DEFAULT_ENDPOINT = 'http://api.gemprospector.com/v1/specifications.json'

    attr_reader :endpoint

    def self.deliver(*args)
      new.deliver(*args)
    end

    def initialize(endpoint = DEFAULT_ENDPOINT, secret_token = nil, client_secret = nil)
      @endpoint       = URI(endpoint)
      @secret_token   = secret_token
      @client_secret  = client_secret
    end

    def deliver(specifications, ruby_version)
      set_request_body(specifications, ruby_version)

      case response.code
      when "401" then raise AuthenticationError
      when "402" then raise AccountSubscriptionStatusError, json[:error]
      when "200" then return true
      else
        raise UnknownError
      end
    end

    def client_secret
      @client_secret ||= Prospector.configuration.client_secret
    end

    def secret_token
      @secret_token ||= Prospector.configuration.secret_token
    end

    private

    def request
      @request ||= build_request
    end

    def response
      @response ||= make_request
    end

    def json
      @json ||= JSON.parse(response.body)
    end

    def build_request
      request = Net::HTTP::Post.new(endpoint)
      request['X-Auth-Token']   = secret_token
      request['X-Auth-Secret']  = client_secret
      request['Content-Type']   = 'application/json'
      request
    end

    def set_request_body(specifications, ruby_version)
      request.body = {
        ruby_version: ruby_version.to_json,
        specifications: hash_from_specifications(specifications)
      }.to_json
    end

    def make_request
      Net::HTTP.start(endpoint.hostname, endpoint.port) do |http|
        http.request(request)
      end
    end

    def hash_from_specifications(specifications)
      specifications.to_a.map do |spec|
        {
          name: spec.name,
          version: spec.version.to_s
        }
      end
    end
  end
end
