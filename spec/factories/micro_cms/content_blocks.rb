# frozen_string_literal: true

FactoryBot.define do
  factory :micro_cms_content_block, class: 'ContentBlock' do
    path { 'MyString' }
    content { 'MyText' }
  end
end
