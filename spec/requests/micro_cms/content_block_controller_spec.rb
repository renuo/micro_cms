# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicroCms::ContentBlockController, type: :request do
  describe '#update' do
    subject(:request) do
      put content_block_path(content_block, params: { micro_cms_content_block: params }, format: :js)
    end

    let!(:content_block) { create :micro_cms_content_block }
    let(:authorization_token) { 'my-securely-generated-auth-token' }

    before do
      allow(MicroCms).to receive(:authorization_token).and_return authorization_token
    end

    context 'when authorization token is correct' do
      let(:new_content) { 'my new content' }
      let(:params) do
        {
          content: new_content,
          authorization_token: authorization_token
        }
      end

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

    context 'when authorization token is incorrect' do
      let(:evil_content) { 'blubb' }

      let(:params) do
        {
          content: evil_content,
          authorization_token: 'my-evil-spoofing-token'
        }
      end

      it 'raises not found error', :aggregate_failures do
        expect { request }.to raise_exception ActiveRecord::RecordNotFound
        expect(content_block.reload.content).not_to eq evil_content
      end
    end
  end
end
