source "https://rubygems.org"

ruby "2.2.3"

# App
gem "rails", "~> 4.2"
gem "pg"
gem "lograge"
gem "logstash-event"
gem "faker"

## Deployment/Services
gem "recipient_interceptor"
gem "eye-patch", ">= 0.3.0"
gem "aws-sdk-rails"
gem "unicorn", require: false
gem "rollbar"
gem "tablexi-logger"

## Views
gem "active_link_to"
gem "haml-rails"
gem "kaminari"
gem "simple_form"
gem "text_helpers"
gem "jbuilder"
gem "sprockets-jst-str"

# Style
gem "autoprefixer-rails"
gem "sass"
gem "sassc-rails"
gem "sprockets-media_query_combiner"

# Behavior
gem "coffee-rails"
gem "gon"
gem "jquery-rails"
gem "jquery-placeholder-rails"
gem "therubyracer"

# Profiling
gem "skylight"

group :assets do
  gem "uglifier"
end

group :development do
  gem "annotate"
  gem "quiet_assets"
  gem "rubocop"
  gem "scss_lint", require: false
  gem "coffeelint"
  gem "guard-rake", require: false
  gem "web-console"
end

group :development, :deployment do
  gem "capistrano", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-rvm", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-deploytags", require: false
end

group :development, :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "pry"
  gem "pry-rails"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "spring"
end

group :test do
  gem "database_cleaner"
end
