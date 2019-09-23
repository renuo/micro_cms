# frozen_string_literal: true

require 'rails_helper'

module MicroCms
  RSpec.describe ContentBlocksController, type: :routing do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/content_blocks').to route_to('content_blocks#index')
      end

      it 'routes to #new' do
        expect(get: '/content_blocks/new').to route_to('content_blocks#new')
      end

      it 'routes to #show' do
        expect(get: '/content_blocks/1').to route_to('content_blocks#show', id: '1')
      end

      it 'routes to #edit' do
        expect(get: '/content_blocks/1/edit').to route_to('content_blocks#edit', id: '1')
      end

      it 'routes to #create' do
        expect(post: '/content_blocks').to route_to('content_blocks#create')
      end

      it 'routes to #update via PUT' do
        expect(put: '/content_blocks/1').to route_to('content_blocks#update', id: '1')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/content_blocks/1').to route_to('content_blocks#update', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/content_blocks/1').to route_to('content_blocks#destroy', id: '1')
      end
    end
  end
end
