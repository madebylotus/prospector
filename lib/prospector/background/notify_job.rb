module Prospector; module Background
  class NotifyJob < ActiveJob::Base
    def perform
      Prospector.notify! if Prospector.enabled?
    end
  end
end; end
