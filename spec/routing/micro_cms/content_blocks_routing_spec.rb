# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicroCms::ContentBlockController, type: :routing do
  routes { MicroCms::Engine.routes }

  describe 'routing' do
    it 'routes to #update via PUT' do
      expect(put: '/content_block/1').to route_to('micro_cms/content_block#update', path: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/content_block/1').to route_to('micro_cms/content_block#update', path: '1')
    end
  end
end
