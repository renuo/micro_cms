# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicroCms::ContentBlockController, type: :request do
  describe '#update' do
    subject(:request) do
      put content_block_path(content_block, params: { micro_cms_content_block: params }, format: :js)
    end

    let!(:content_block) { create :micro_cms_content_block }
    let(:new_content) { 'my new content' }
    let(:params) { { content: new_content } }

    it 'updates the content block', :aggregate_failures do
      expect { request }.to change { content_block.reload.content }.from(content_block.content).to(new_content)
      expect(response).to have_http_status :no_content
    end

    context 'when the content block cannot be found' do
      let(:content_block) { build(:micro_cms_content_block, path: 'not-existent') }

      it 'throws not found error' do
        expect { request }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
