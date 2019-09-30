# frozen_string_literal: true

require_dependency 'micro_cms/application_controller'

module MicroCms
  class ContentBlockController < ApplicationController
    def update
      respond_to do |format|
        format.js do
          ContentBlock.find_by!(path: params[:path]).update(content: content_block_params[:content])

          head :no_content
        end
      end
    end

    private

    def content_block_params
      params.require(:micro_cms_content_block).permit(:content)
    end
  end
end
