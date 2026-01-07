source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'

# Database
# Database
gem 'pg', '~> 1.1'

gem 'puma', '>= 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'

# Windows Support
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

# Core Deps to avoid version conflicts in Windows
gem 'public_suffix', '< 6.0'
gem 'drb'
gem 'mutex_m'
gem 'base64'
gem 'bigdecimal'

gem 'bootsnap', require: false

# Auth & Admin
gem 'devise'
gem 'pundit'
gem 'activeadmin'
gem 'ransack'
gem 'sassc' 

# File Uploads
gem 'image_processing', '~> 1.2'

# Payments
gem 'stripe'

# Env
gem 'dotenv-rails', groups: [:development, :test]

group :development, :test do
  # gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
