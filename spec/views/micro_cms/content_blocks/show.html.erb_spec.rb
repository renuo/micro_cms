# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'content_blocks/show', type: :view do
  before do
    @content_block = assign(:content_block, ContentBlock.create!(
                                              path: 'Path',
                                              content: 'MyText'
                                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Path/)
    expect(rendered).to match(/MyText/)
  end
end
