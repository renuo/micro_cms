# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'content_blocks/index', type: :view do
  before do
    assign(:content_blocks, [
             ContentBlock.create!(
               path: 'Path',
               content: 'MyText'
             ),
             ContentBlock.create!(
               path: 'Path',
               content: 'MyText'
             )
           ])
  end

  it 'renders a list of content_blocks' do
    render
    assert_select 'tr>td', text: 'Path'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
