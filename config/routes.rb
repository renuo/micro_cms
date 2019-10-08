# frozen_string_literal: true

MicroCms::Engine.routes.draw do
  resources :content_block, only: :update, param: :path
end
