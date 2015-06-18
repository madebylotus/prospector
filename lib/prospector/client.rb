module Prospector
  class Client
    def self.deliver(*args)
      new.deliver(*args)
    end

    def deliver(specifications)
      set_request_body(specifications)

      case response.code
      when "401" then raise AuthenticationError
      when "200" then return true
      else
        raise UnknownError
      end
    end

    private

    def request
      @request ||= build_request
    end

    def response
      @response ||= make_request
    end

    def endpoint
      @endpoint ||= URI('http://api.gemprospector.com/v1/specifications.json')
    end

    def build_request
      request = Net::HTTP::Post.new(endpoint)
      request['X-Auth-Token']   = Prospector.configuration.secret_token
      request['X-Auth-Secret']  = Prospector.configuration.client_secret
      request['Content-Type']   = 'application/json'
      request
    end

    def set_request_body(specifications)
      request.body = {
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
