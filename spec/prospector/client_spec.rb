require 'spec_helper'

module Prospector
  describe Client do
    before do
      Prospector.configure do |config|
        config.secret_token = 'username'
        config.client_secret = 'password'
      end
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
  end
end
