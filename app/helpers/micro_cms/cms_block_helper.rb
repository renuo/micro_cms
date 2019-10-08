# frozen_string_literal: true

module MicroCms
  module CmsBlockHelper
    def cms_block(path, default = nil, &block)
      content_block = content_block_for_path(path, default: capture_default(default, &block))

      render partial: 'micro_cms/content_block', locals: { content_block: content_block }
    end

    def cms_content(path, default = nil, &block)
      content_block = content_block_for_path(path, default: capture_default(default, &block))

      content_tag :div, content_block.content, nil, false
    end

    private

    def content_block_for_path(path, default:)
      MicroCms::ContentBlock.content_block_for_path path, content: default || ''
    end

    def capture_default(default)
      default = capture { yield } if block_given? && default.nil?
      default
    end
  end
end
