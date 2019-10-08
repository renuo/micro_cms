# frozen_string_literal: true

RSpec.shared_examples_for 'creates a new content block at the given path' do
  it 'creates a new content block at the given path', :aggregate_failures do
    expect { subject_method }.to change(MicroCms::ContentBlock, :count).by 1
    expect(content_block.content).to eq content
    expect(content_block.path).to eq MicroCms::ContentBlock.format_path path
  end
end
