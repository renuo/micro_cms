# frozen_string_literal: true

RSpec.describe 'micro_cms/_content_block.html.erb', type: :view do
  let(:content_block) { create :micro_cms_content_block }

  before do
    render partial: 'micro_cms/content_block', locals: { content_block: content_block }
  end

  it 'contains the content' do
    expect(rendered).to include content_block.content
  end

  it 'contains the contenteditable CMS block' do
    expect(rendered).to have_selector('div[contenteditable=true]')
  end

  it 'contains the path as id' do
    expect(rendered).to have_selector("div[id=\"#{content_block.path}\"]")
  end

  it 'has a valid update url' do
    expect(rendered).to have_selector("div[data-update-url=\"#{content_block_path(content_block)}\"]")
  end
end
