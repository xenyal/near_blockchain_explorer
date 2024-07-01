source "https://rubygems.org"

ruby "2.7.7"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"
gem "sprockets-rails"
gem "pg", "~> 1.5.6"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "bootsnap", require: false
gem "pry-rails"

# JSON Serialiazation
gem "oj"
gem "panko_serializer"

# JS/React asset compilation
gem 'jsbundling-rails'

# Background job processor
gem "sidekiq", "~> 7.2"
gem "sidekiq-cron", "~> 1.12.0"
gem "redis", ">= 4.0.1"

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem "dotenv-rails"
end

group :development do
  gem "web-console"
  gem 'annotate'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "database_cleaner"
end
