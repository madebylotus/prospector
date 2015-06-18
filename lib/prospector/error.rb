module Prospector
  class Error < StandardError; end
  class AuthenticationError < Error; end
  class InvalidCredentialsError < Error; end
  class UnknownError < Error; end
end
