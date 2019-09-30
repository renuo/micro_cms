# frozen_string_literal: true

module MicroCms
  module CmsBlockHelper
    def cms_block(path, default = nil)
      default = capture { yield } if block_given? && default.nil?
      content_block = MicroCms::ContentBlock.content_block_for_path path, content: default || ''

      render partial: 'micro_cms/content_block', locals: { content_block: content_block }
    end
  end
end
