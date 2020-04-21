# MicroCms
Provides editable inline content blocks to modify your content on the fly.

## Dependencies
* [`ckeditor`](https://github.com/galetahub/ckeditor) gem.
* jQuery 

## Usage
To provide an editable content block, use the `cms_block` helper method in your view, e.g.:
```slim
= cms_block 'my.unique.block.identifier'
  h1 Default
  p This is my default content
```

To print the content in readonly mode, use the `cms_content` helper method in your view, e.g:
```slim
= cms_content 'my.unique.block.identifier'
  p My content if there's no content block yet
```

It's best to write an own helper method which also does authentication like
```ruby
def cms(path, &block)
  if current_user&.write_cms?
    cms_block(path, &block)
  else
    cms_content(path, &block)
  end
end
```

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

Mount the engine routes in you `config/routes.rb` file:
```ruby
mount MicroCms::Engine => '/micro_cms'
```

### Usage with Sprockets

Require the JavaScript (e.g. `//= require micro_cms`) and all styles (e.g. `@import 'micro_cms';'`).

### Usage with Webpacker

Make sure that you import `rails/ujs` like that in your `application.js`:

```js
import Rails from '@rails/ujs';
Rails.start();
...
window.Rails = Rails;
```

The last line makes the Rails scope global (since we inline the script, this is needed).

Now you have to include the helper to your ApplicationHelper:

```rb
module ApplicationHelper
  include MicroCms::ApplicationHelper
  ...
end
```

Now you can use the helper to inline the needed scripts via `app/views/layouts/application.html.slim`. It's strongly
recommended to check first, if the user is allowed to edit (but this is not part of this gem):

```rb
- if user_signed_in? # not part of this gem!
  = micro_cms_asset_tags
```


## Configuration
`app/config/initializers/micro_cms.rb`:

```ruby
MicroCms.configure do |config|
  config.ckeditor_configuration_file = 'ckeditor/config.js' # Custom ckeditor config. Optional
end
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
