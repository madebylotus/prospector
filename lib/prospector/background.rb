module Prospector
  module Background
    autoload :Coordinator,  'prospector/background/coordinator'
    autoload :NotifyJob,    'prospector/background/notify_job'
    autoload :NotifyWorker, 'prospector/background/notify_worker'

    def enqueue
      Coordinator.new.enqueue
    end

    module_function :enqueue
  end
end
