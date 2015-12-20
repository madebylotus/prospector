require 'spec_helper'

module Prospector
  describe Client do
    before do
      Prospector.configure do |config|
        config.secret_token = 'username'
        config.client_secret = 'password'
      end
    end

    it 'returns the default endpoint' do
      expect(subject.endpoint).to eq(URI(Prospector::Client::DEFAULT_ENDPOINT))
    end

    context 'with invalid credentials' do
      let(:specifications) { [] }

      it 'raises error' do
        VCR.use_cassette 'invalid credentials' do
          expect { subject.deliver(specifications) }.to raise_error(AuthenticationError)
        end
      end
    end

    context 'with valid credentials' do
      let(:specification) { double(name: 'devise', version: Gem::Version.new('4.2.1')) }
      let(:specifications) { [ specification ] }

      it 'returns true' do
        VCR.use_cassette 'valid credentials' do
          expect(subject.deliver(specifications)).to be_truthy
        end
      end
    end

    context 'when encountering an error' do
      let(:specifications) { [] }

      it 'raises an exception for a 500 error' do
        VCR.use_cassette 'server 500 error' do
          expect { subject.deliver(specifications) }.to raise_error(UnknownError)
        end
      end

      it 'warns for expired accounts' do
        VCR.use_cassette 'expired_trial' do
          expect { subject.deliver(specifications) }.to raise_error(AccountSubscriptionStatusError)
        end
      end

      it 'warns for cancelled accounts' do
        VCR.use_cassette 'cancelled_subscription' do
          expect { subject.deliver(specifications) }.to raise_error(AccountSubscriptionStatusError)
        end
      end
    end

    describe 'when provided custom endpoint and credentials' do
      let(:specifications) { [] }

      subject do
        described_class.new('http://api.lvh.me:3000', 'custom_token', 'custom_secret')
      end

      it 'returns the endpoint as a URI' do
        expect(subject.endpoint).to be_a(URI)
      end

      it 'returns the correct endpoint we passed in' do
        expect(subject.endpoint).to eq(URI('http://api.lvh.me:3000'))
      end

      it 'returns our custom token' do
        expect(subject.secret_token).to eq('custom_token')
      end

      it 'returns our custom secret' do
        expect(subject.client_secret).to eq('custom_secret')
      end
    end
  end
end
