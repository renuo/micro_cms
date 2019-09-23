# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'content_blocks/edit', type: :view do
  before do
    @content_block = assign(:content_block, ContentBlock.create!(
                                              path: 'MyString',
                                              content: 'MyText'
                                            ))
  end

  it 'renders the edit content_block form' do
    render

    assert_select 'form[action=?][method=?]', content_block_path(@content_block), 'post' do
      assert_select 'input[name=?]', 'content_block[path]'

      assert_select 'textarea[name=?]', 'content_block[content]'
    end
  end
end
