# frozen_string_literal: true

class CreateMicroCmsContentBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :micro_cms_content_blocks do |t|
      t.string :path
      t.text :content

      t.timestamps
    end
  end
end
