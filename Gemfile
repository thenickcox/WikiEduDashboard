source 'https://rubygems.org'
ruby '2.1.6'
gem 'rails', '4.1.8'
gem 'jbuilder', '~> 2.0'

gem 'mediawiki-gateway'
gem 'crack'
gem 'figaro'
gem 'whenever'
gem 'mysql2'

gem 'devise'
gem 'omniauth-mediawiki'

gem 'sentry-raven'
gem 'piwik_analytics', :git => 'https://github.com/halfdan/piwik-ruby-tracking.git'

# This fork has a fix for enums not working
# https://github.com/zdennis/activerecord-import/issues/139
gem 'activerecord-import', :git => 'https://github.com/onemedical/activerecord-import.git'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'guard-livereload', :require=>false
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'zeus'
  gem 'sqlite3'
end

group :staging, :production do
  gem 'pg'
end

group :test do
  gem 'rake'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'webmock'
  gem 'vcr', github: 'vcr/vcr'
  gem 'simplecov', :require => false
  gem "codeclimate-test-reporter", require: nil
end
