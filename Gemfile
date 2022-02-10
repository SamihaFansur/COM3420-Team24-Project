source "https://rubygems.org"
ruby '2.7.4'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'rails', '~> 6.1', '>= 6.1.4'
gem 'activerecord-session_store'
gem 'bootsnap'
gem 'responders'
gem 'puma'

gem 'webpacker'

gem 'pg'

gem 'hamlit'
gem 'hamlit-rails'

gem 'simple_form'
gem 'draper'
gem 'ransack'

gem 'will_paginate'
gem 'bootstrap-will_paginate'

gem 'devise'
gem 'cancancan'
gem "epi_cas", git: "git@git.shefcompsci.org.uk:gems/epi_cas.git"


gem 'whenever'
gem 'delayed_job'
gem 'delayed_job_active_record'

gem 'daemons'

gem 'sentry-ruby'
gem 'sentry-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'byebug'
  gem 'sqlite3'
end

group :development do
  gem 'epi_deploy', github: 'epigenesys/epi_deploy'

  gem 'listen'
  gem 'web-console'

  gem 'capistrano'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-passenger', require: false

  gem 'letter_opener'
  gem 'annotate'
end

group :test do
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'webdrivers'

  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov'
end
