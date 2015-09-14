module Motion; module Project; class Config
  variable :prospector

  def prospector(&block)
    Prospector.configure(&block) if block_given?

    Prospector.configuration
  end
end; end; end
