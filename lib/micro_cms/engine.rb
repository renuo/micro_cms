# frozen_string_literal: true

module MicroCms
  class Engine < ::Rails::Engine
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
  end
end
