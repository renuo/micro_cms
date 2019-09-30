# frozen_string_literal: true

require 'singleton'

class AuthorizationToken
  include Singleton

  attr_reader :token

  def initialize
    @token = SecureRandom.urlsafe_base64
  end
end
