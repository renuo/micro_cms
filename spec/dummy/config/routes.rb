# frozen_string_literal: true

Rails.application.routes.draw do
  mount MicroCms::Engine => '/micro_cms'
end
