# frozen_string_literal: true

require 'micro_cms/engine'

module MicroCms
  mattr_accessor :ckeditor_configuration_file
  @ckeditor_configuration_file = nil

  def self.configure
    yield self
  end
end
