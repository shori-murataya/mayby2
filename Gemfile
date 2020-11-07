source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3'
gem 'bcrypt'
gem 'rails-i18n'
gem 'kaminari'
gem 'ransack'
gem 'must_be_ordered'
gem 'devise'
gem 'devise-i18n'
gem 'haml-rails'
gem 'bootstrap'
gem 'dekiru'
gem 'actiontext'
gem 'image_processing', '~> 1.2'
gem 'dotenv-rails'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'activestorage-validator'
gem 'aws-sdk-s3', require: false
gem 'rails_admin', '~> 2.0.0.beta'
gem 'cancancan'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'webpacker', '~> 4.0'
gem 'mini_magick', '~> 4.8'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'mysql2'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'simplecov'
end

group :production do
  gem 'mysql2'
end

group :production, :staging do
  gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]