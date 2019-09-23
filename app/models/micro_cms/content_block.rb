# frozen_string_literal: true

module MicroCms
  class ContentBlock < ApplicationRecord
    validates :path, presence: true

    def self.table_name_prefix
      'micro_cms_'
    end

    def self.format_path(i18n_key)
      "#{i18n_key.parameterize}-#{I18n.locale}"
    end

    def self.content_block_for_path(path, content: '')
      ContentBlock.find_or_create_by(path: format_path(path)) do |content_block|
        content_block.content = content
      end
    end

    def to_param
      path
    end
  end
end
