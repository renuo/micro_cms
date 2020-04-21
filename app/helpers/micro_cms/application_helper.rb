# frozen_string_literal: true

module MicroCms
  module ApplicationHelper
    # rubocop:disable Rails/OutputSafety
    def micro_cms_asset_tags
      js = load_gem_file 'micro_cms', 'app/assets/javascripts/micro_cms.js'
      css = load_gem_file 'micro_cms', 'app/assets/stylesheets/micro_cms/micro_cms.css'
      tag.script(js.html_safe) + tag.style(css)
    end
    # rubocop:enable Rails/OutputSafety

    private

    def load_gem_file(gem_name, assets_path)
      path = File.join(Gem.loaded_specs[gem_name].full_gem_path, assets_path)
      File.read(path)
    end
  end
end
