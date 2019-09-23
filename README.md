# MicroCms
Short description and motivation.

## Dependencies
* [`ckeditor`](https://github.com/galetahub/ckeditor) gem.
* jQuery 

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'micro_cms'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install micro_cms
```

In your app, run 
```bash
bin/bundle exec rake micro_cms:install:migrations
bin/rails db:migrate
```
to copy the migrations.

Require the JavaScript (e.g. `//= require micro_cms`) and all styles (e.g. `@import 'micro_cms';'`).

## Configuration
`app/config/initializers/micro_cms.rb`:

```ruby
MicroCms.configure do |config|
  config.ckeditor_configuration_file = 'ckeditor/config.js' # Custom ckeditor config. Optional
end
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
