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
        include MicroCms::CmsBlockHelper
      end
    end
  end
end
