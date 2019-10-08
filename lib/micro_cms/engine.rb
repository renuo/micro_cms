# frozen_string_literal: true

begin
  require 'factory_bot_rails'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

module MicroCms
  class Engine < ::Rails::Engine
    FACTORIES = File.expand_path('../../spec/factories', __dir__).freeze

    isolate_namespace MicroCms

    config.generators do |generators|
      generators.test_framework :rspec
      generators.fixture_replacement :factory_bot
      generators.factory_bot dir: 'spec/factories'
    end

    initializer 'micro_cms.include_view_helpers' do |_app|
      ActiveSupport.on_load :action_view do
        ActionView::Base.public_send :include, MicroCms::CmsBlockHelper
      end
    end

    initializer 'micro_cms.configure_authorization_token' do |_app|
      MicroCms.configure do |config|
        config.authorization_token = SecureRandom.urlsafe_base64
      end
    end

    if defined? FactoryBotRails
      initializer 'mirco_cms.set_factory_paths', after: 'factory_bot.set_factory_paths' do |_app|
        FactoryBot.definition_file_paths << FACTORIES
      end
    end
  end
end
