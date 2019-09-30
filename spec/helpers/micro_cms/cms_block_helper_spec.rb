# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicroCms::CmsBlockHelper, type: :helper do
  let(:created_content_block) { MicroCms::ContentBlock.order(:created_at).last }

  let(:sample_default_template) do
    ERB.new <<-ERB.chomp
      <p>This is my custom content</p>
    ERB
  end

  describe '#cms_block' do
    subject(:cms_block) { helper.cms_block(path, default) }

    let(:path) { 'my.custom.path' }
    let(:default) { nil }
    let(:subject_method) { cms_block }

    context 'when the content block does not exist' do
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
          helper.cms_block(path, &sample_default_template.method(:result))
        end

        it_behaves_like 'creates a new content block at the given path' do
          let(:content) { ERB::Util.html_escape sample_default_template.result }
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

    context 'when the block does already exist' do
      let!(:content_block) { create :micro_cms_content_block, path: MicroCms::ContentBlock.format_path(path) }
      let(:path) { 'my.custom.path' }

      describe 'rendered partial' do
        let(:partial_params) do
          { partial: 'micro_cms/content_block', locals: { content_block: content_block } }
        end

        before do
          allow(helper).to receive(:render)
        end

        it 'renders the correct partial' do
          helper.cms_block(path)
          expect(helper).to have_received(:render).with(partial_params)
        end
      end
    end
  end

  describe '#cms_content' do
    subject(:cms_content) { helper.cms_content(path, default) }

    let(:subject_method) { cms_content }
    let(:default) { 'my default' }

    context 'when the content block already exists' do
      let(:formatted_path) { MicroCms::ContentBlock.format_path(path) }
      let(:path) { 'my.custom.path' }
      let(:content) { 'my custom content of the block' }

      before { create :micro_cms_content_block, path: formatted_path, content: content }

      it 'renders the content', :aggregate_failures do
        expect(cms_content).to include content
        expect(cms_content).to_not include 'contenteditable'
      end
    end

    context 'when the content block does not exist yet' do
      let(:path) { 'my.nonexistent.path' }

      context 'when the default param is given' do
        let(:default) { 'my default value' }

        it_behaves_like 'creates a new content block at the given path' do
          let(:content) { default }
          let(:content_block) { created_content_block }
        end
      end

      context 'when a default block is given' do
        subject(:cms_content) do
          helper.cms_content(path, &sample_default_template.method(:result))
        end

        it_behaves_like 'creates a new content block at the given path' do
          let(:content) { ERB::Util.html_escape sample_default_template.result }
          let(:content_block) { created_content_block }
        end
      end

      context 'when no default is given' do
        let(:default) { nil }

        it_behaves_like 'creates a new content block at the given path' do
          let(:content) { '' }
          let(:content_block) { created_content_block }
        end
      end
    end
  end
end
