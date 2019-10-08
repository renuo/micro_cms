# frozen_string_literal: true

require_dependency 'micro_cms/application_controller'

module MicroCms
  class ContentBlockController < ApplicationController
    def update
      check_authorization_token

      respond_to do |format|
        format.js do
          ContentBlock.find_by!(path: params[:path]).update(content: content_block_params[:content])

          head :no_content
        end
      end
    end

    private

    def check_authorization_token
      token = content_block_params[:authorization_token]

      raise ActiveRecord::RecordNotFound unless token == MicroCms.authorization_token
    end

    def content_block_params
      params.require(:micro_cms_content_block).permit(:content, :authorization_token)
    end
  end
end
