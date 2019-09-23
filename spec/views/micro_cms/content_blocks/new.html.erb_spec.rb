# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'content_blocks/new', type: :view do
  before do
    assign(:content_block, ContentBlock.new(
                             path: 'MyString',
                             content: 'MyText'
                           ))
  end

  it 'renders new content_block form' do
    render

    assert_select 'form[action=?][method=?]', content_blocks_path, 'post' do
      assert_select 'input[name=?]', 'content_block[path]'

      assert_select 'textarea[name=?]', 'content_block[content]'
    end
  end
end
