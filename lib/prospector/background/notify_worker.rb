module Prospector; module Background
  class NotifyWorker
    include Sidekiq::Worker

    def perform
      Prospector.notify! if Prospector.enabled?
    end
  end
end; end
