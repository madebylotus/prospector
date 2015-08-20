module Prospector; module Background
  class NotifyJob < ActiveJob::Base
    def perform
      Prospector.notify!
    end
  end
end; end
