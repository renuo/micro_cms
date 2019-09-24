# frozen_string_literal: true

FactoryBot.define do
  factory :micro_cms_content_block, class: MicroCms::ContentBlock do
    path { 'my-path-de' }
    content { 'MyText' }
  end
end
