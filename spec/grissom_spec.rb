require 'spec_helper'

describe Prospector do
  it 'has a version number' do
    expect(Prospector::VERSION).not_to be nil
  end

  describe '#configure' do
    it 'yields a configuration instance' do
      expect { |b| subject.configure(&b) }.to yield_with_args(kind_of(Prospector::Configuration))
    end

    it 'persists the configuration instance' do
      subject.configure do |config|
        config.secret_token = 'token'
      end

      expect(subject.configuration.secret_token).to eq('token')
    end
  end
end
