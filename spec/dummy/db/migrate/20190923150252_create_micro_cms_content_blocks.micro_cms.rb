# frozen_string_literal: true
# This migration comes from micro_cms (originally 20190923103919)

class CreateMicroCmsContentBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :micro_cms_content_blocks do |t|
      t.string :path
      t.text :content

      t.timestamps
    end
  end
end
