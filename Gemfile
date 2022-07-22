source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'better_errors', '~> 2.9', '>= 2.9.1'
gem 'devise'

#page pagination and styling
gem 'will_paginate', '~> 3.3'
gem 'will_paginate-bootstrap4'

#user avatar
gem 'carrierwave', '~> 2.0'

#slim
gem 'slim-rails', '~> 3.5', '>= 3.5.1'

#view logic removal
gem 'draper'

#internalization
gem 'i18n'

#phone validation
gem 'telephone_number'

#payment
gem 'stripe', '~> 6.5'

#permissions
gem "pundit", "~> 2.2"

#searching 
gem 'ransack', '~> 3.2', '>= 3.2.1'

#sending emails 
gem 'delayed_job_active_record'
gem "daemons"
gem "sidekiq"

#fast posts 
gem "faker"

#jobs 
gem 'whenever', require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "shoulda-matchers", "~> 5.0"
end

