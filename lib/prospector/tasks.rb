require 'rake'

namespace :prospector do

  # Will load and run initializers for configuration info if provided
  task :require do
    if defined?(Rails)
      Rake::Task['environment'].invoke
    end
  end

  desc 'Deliver usage details to Prospector API service'
  task deliver: ['prospector:require'] do
    Prospector.notify!
  end
end
