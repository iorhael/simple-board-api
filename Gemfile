# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# A Ruby client library for Redis [https://github.com/redis/redis-rb]
gem 'redis'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible [https://github.com/cyu/rack-cors]
gem 'rack-cors'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  # RSpec for Rails 6+ [https://github.com/rspec/rspec-rails/tree/6-1-maintenance?tab=readme-ov-file]
  gem 'rspec-rails', '~> 6.1.0'
  # Library for generating fake data [https://github.com/faker-ruby/faker]
  gem 'faker'
  # Factory_bot_rails provides Rails integration for factory_bot [https://github.com/thoughtbot/factory_bot_rails]
  gem 'factory_bot_rails'
  # Enforcing Rails best practices and coding conventions [https://github.com/rubocop/rubocop-rails]
  gem 'rubocop-rails', require: false
  # Code style checking for RSpec files [https://github.com/rubocop/rubocop-rspec]
  gem 'rubocop-rspec', require: false
  # An extension of RuboCop focused on code performance checks [https://github.com/rubocop/rubocop-performance]
  gem 'rubocop-performance', require: false
  # Patch-level verification for Bundler [https://github.com/rubysec/bundler-audit]
  gem 'bundler-audit'
  # Known-leaky gems verification for bundler [https://github.com/rubymem/bundler-leak]
  gem 'bundler-leak'
  # A Ruby gem to load environment variables from `.env` [https://github.com/bkeepers/dotenv]
  gem 'dotenv-rails'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  # Make your Rubies go faster [https://github.com/DamirSvrtan/fasterer]
  gem 'fasterer'
end

group :test do
  # Simple one-liner tests for common Rails functionality [https://github.com/thoughtbot/shoulda-matchers]
  gem 'shoulda-matchers', '~> 6.0'
  # Code coverage for Ruby [https://github.com/simplecov-ruby/simplecov]
  gem 'simplecov', require: false
  # Cleaning databases using ActiveRecord [https://github.com/DatabaseCleaner/database_cleaner-active_record]
  gem 'database_cleaner-active_record'
  # Cleaning redis databases [https://github.com/DatabaseCleaner/database_cleaner-redis]
  gem 'database_cleaner-redis'
end
