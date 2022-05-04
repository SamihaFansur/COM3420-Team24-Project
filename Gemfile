source 'https://rubygems.org'
ruby '2.7.4'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'activerecord-session_store'
gem 'bootsnap'
gem 'puma'
gem 'rails', '~> 6.1', '>= 6.1.4'
gem 'responders'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem 'webpacker'

gem 'pg'

gem 'hamlit'
gem 'hamlit-rails'

gem 'draper'
gem 'ransack'
gem 'simple_form'
gem 'vanilla_nested'

gem 'bootstrap-will_paginate'
gem 'will_paginate'

gem 'cancancan'
gem 'devise'
gem 'epi_cas', git: 'git@git.shefcompsci.org.uk:gems/epi_cas.git'

gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'whenever'

gem 'daemons'

gem 'sentry-rails'
gem 'sentry-ruby'

gem 'activestorage-database-service', github: 'TitovDigital/activestorage-database-service'
gem 'active_storage_validations'
gem 'cairo-gobject'
gem 'glib2'
gem 'gobject-introspection'
gem 'image_processing', '~> 1.2'
gem 'poppler'

gem 'sass-rails'

gem 'date_validator'

gem 'activerecord-import'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'sqlite3'

  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'epi_deploy', github: 'epigenesys/epi_deploy'

  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'ed25519', '>= 1.2', '< 2.0'

  gem 'listen'
  gem 'web-console'

  gem 'capistrano'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false

  gem 'annotate'
  gem 'letter_opener'
end

group :test do
  gem 'capybara', '>= 2.4.4'
  gem 'factory_bot_rails'
  gem 'webdrivers'

  gem 'database_cleaner'
  gem 'launchy'
  gem 'pdf-reader'
  gem 'poltergeist'
  gem 'simplecov'
end
