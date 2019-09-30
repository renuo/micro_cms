# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MicroCms::ContentBlock, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :path }
    it { is_expected.to validate_exclusion_of(:content).in_array([nil]) }
  end

  describe '#self.table_name_prefix' do
    it 'prefixes db table name' do
      expect(described_class.table_name_prefix).to eq 'micro_cms_'
    end
  end

  describe '#self.format_path' do
    subject(:formatted_path) { described_class.format_path(i18n_key) }

    let(:i18n_key) { 'my.key.to.success' }

    before { I18n.locale = :en }

    after { I18n.locale = I18n.default_locale }

    it 'returns the formatted path' do
      expect(formatted_path).to eq 'my-key-to-success-en'
    end
  end

  describe '#self.content_block_for_path' do
    let(:path) { 'my.content.block' }

    context 'when the content block already exists' do
      let!(:content_block) { create :micro_cms_content_block, path: described_class.format_path(path) }

      it 'returns the content block for the given path' do
        expect(described_class.content_block_for_path(path)).to eq content_block
      end
    end

    context 'when the content block does not exist yet' do
      subject(:create_content_block) { described_class.content_block_for_path(path, content: new_content) }

      let(:new_content) { 'my content' }
      let(:formatted_path) { described_class.format_path path }
      let(:created_content_block) { described_class.order(:created_at).last }

      it 'creates a new one with default params', :aggregate_failures do
        expect { create_content_block }.to change(described_class, :count)
        expect(created_content_block.path).to eq formatted_path
        expect(created_content_block.content).to eq new_content
      end
    end
  end

  describe '#to_param' do
    subject { build(:micro_cms_content_block, path: 'my-path-de').to_param }

    it { is_expected.to eq 'my-path-de' }
  end
end
