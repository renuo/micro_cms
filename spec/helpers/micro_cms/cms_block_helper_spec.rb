# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicroCms::CmsBlockHelper, type: :helper do
  describe '#cms_block' do
    subject(:cms_block) { helper.cms_block(path, default) }

    let(:path) { 'my.custom.path' }
    let(:default) { nil }

    context 'when the content block does not exist' do
      let(:created_content_block) { MicroCms::ContentBlock.order(:created_at).last }

      describe 'rendered partial' do
        let(:partial_params) do
          { partial: 'micro_cms/content_block', locals: { content_block: created_content_block } }
        end

        before do
          allow(helper).to receive(:render)
          cms_block
        end

        it 'renders the correct partial' do
          expect(helper).to have_received(:render).with(partial_params)
        end
      end

      context 'when a block is given' do
        subject(:cms_block) do
          helper.cms_block(path, &template.method(:result))
        end

        let(:template) do
          ERB.new <<-ERB.chomp
            <p>This is my custom content</p>
          ERB
        end

        it_behaves_like 'creates a new content block at the given path' do
          let(:content) { ERB::Util.html_escape template.result }
          let(:content_block) { created_content_block }
        end
      end

      context 'when a default param is given' do
        let(:default) { 'my default value' }

        it_behaves_like 'creates a new content block at the given path' do
          let(:content) { default }
          let(:content_block) { created_content_block }
        end
      end

      context 'when no default is given' do
        it_behaves_like 'creates a new content block at the given path' do
          let(:content) { '' }
          let(:content_block) { created_content_block }
        end
      end
    end
  end
end
