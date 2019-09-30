# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'lib/micro_cms/version.rb'
end
SimpleCov.minimum_coverage 100

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment.rb', __dir__)

require 'rspec/rails'
require 'factory_bot'
require 'micro_cms'
require 'capybara/rspec/matchers'

Rails.backtrace_cleaner.remove_silencers!
ActiveRecord::Migrator.migrations_paths = 'spec/dummy/db/migrate'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10
  config.order = :random
  config.include FactoryBot::Syntax::Methods
  config.include MicroCms::Engine.routes.url_helpers
  config.include Capybara::RSpecMatchers, type: :view

  Kernel.srand config.seed
end
