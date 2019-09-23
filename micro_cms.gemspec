# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'micro_cms/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = 'micro_cms'
  spec.version = MicroCms::VERSION
  spec.authors = ['Lukas Bischof']
  spec.email = ['lukas.bischof@renuo.ch']
  spec.homepage = 'https://github.com/renuo/micro_cms'
  spec.summary = 'An inline micro cms'
  spec.description = 'Provides a cms block which can be edited inline'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '> 5.2.0'

  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
end
