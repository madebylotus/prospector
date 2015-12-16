module Prospector; module Background
  class EnvironmentDetector
    RAILS_SERVERS = %w(passenger unicorn puma thin rainbows webrick).freeze

    def rails_server?
      RAILS_SERVERS.each do |server_name|
        return true if send("running_#{ server_name }?")
      end

      false
    end

    private

    def running_passenger?
      defined?(::PhusionPassenger)
    end

    def running_unicorn?
      return false unless defined?(::Unicorn) && defined?(::Unicorn::HttpServer)

      running_instance_of?(::Unicorn::HttpServer)
    end

    def running_puma?
      defined?(::Puma) && File.basename($0) == 'puma'
    end

    def running_thin?
      return false unless defined?(::Thin) && defined?(::Thin::Server)

      running_instance_of?(::Thin::HttpServer)
    end

    def running_rainbows?
      return false unless defined?(::Rainbows) && defined?(::Rainbows::HttpServer)

      running_instance_of?(::Rainbows::HttpServer)
    end

    def running_webrick?
      defined?(::WEBrick) && defined?(::WEBrick::VERSION)
    end

    def running_instance_of?(klass)
      ObjectSpace.each_object(klass).any?
    end
  end
end; end
