module Prospector
  class Error < StandardError; end
  class AuthenticationError < Error; end
  class InvalidCredentialsError < Error; end
  class AccountSubscriptionStatusError < Error; end
  class NotEnabledError < Error; end
  class UnsupportedAdapterError < Error; end
  class UnknownError < Error; end
end
