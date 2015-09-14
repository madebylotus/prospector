require 'rake'

namespace :prospector do

  # Will load and run initializers for configuration info if provided
  task :require do
    Rake::Task['environment'].invoke if defined?(Rails)

    App.config if defined?(Motion::Project)
  end

  desc 'Deliver usage details to Prospector API service'
  task deliver: ['prospector:require'] do
    Prospector.notify!
  end
end
