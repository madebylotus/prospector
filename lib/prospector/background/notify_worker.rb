module Prospector; module Background
  class NotifyWorker
    include Sidekiq::Worker

    def perform
      Prospector.notify!
    end
  end
end; end
