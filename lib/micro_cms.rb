# frozen_string_literal: true

require 'micro_cms/engine'
require 'micro_cms/authorization_token'

module MicroCms
  mattr_accessor :ckeditor_configuration_file
  @ckeditor_configuration_file = nil

  def self.authorization_token
    AuthorizationToken.instance.token
  end

  def self.configure
    yield self
  end
end
