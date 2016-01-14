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

  describe '#enabled?' do
    it 'delegates to the configuration instance' do
      expect_any_instance_of(Prospector::Configuration).to receive(:enabled?).and_return(true)

      expect(subject).to be_enabled
    end
  end

  describe '#notify!' do
    context 'when disabled' do
      before do
        Prospector.configure do |config|
          config.enabled = false
        end
      end

      it 'raises an error' do
        expect { subject.notify! }.to raise_error(Prospector::NotEnabledError)
      end
    end

    context 'when enabled' do
      before do
        Prospector.configure do |config|
          config.enabled = true
        end
      end

      it 'marks the delivery' do
        allow(Prospector::Client).to receive(:deliver)
        expect_any_instance_of(Prospector::Configuration).to receive(:notify!)

        subject.notify!
      end

      it 'delivers the specifications' do
        allow(Bundler).to receive(:environment).and_return(double(specs: []))
        expect(Prospector::Client).to receive(:deliver).with([], Prospector.ruby_version)

        subject.notify!
      end
    end
  end
end
