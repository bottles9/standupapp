source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass','3.3.6'   
gem 'slim-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis'  
gem 'redis-rails'
# Use ActiveModel has_secure_password
 gem 'bcrypt', '3.1.12'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capybara','>= 2.15'
  gem 'faker'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'vcr'
  gem 'webmock'
  gem 'rails-controller-testing'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
   gem 'foreman'
   gem 'letter_opener_web', '~> 1.3', '>= 1.3.4'
  # gem 'letter_opener'
   gem 'binding_of_caller'
   gem 'better_errors'
   
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
 # gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers', '~> 4.1','>= 4.1.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'
gem 'rack-cors', :require => 'rack/cors'

gem 'aasm'
gem 'lodash-rails'
gem 'local_time'
gem 'devise'
gem 'devise_invitable'
gem 'rolify'
gem 'cancancan'
gem 'paper_trail' 
gem 'ranked-model'
gem 'friendly_id'  
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sinatra', github: 'sinatra/sinatra', require: nil
gem 'sidekiq-statistic'
gem 'gravatar_image_tag'
gem 'country_select'
gem 'kaminari'
gem 'money-rails'
gem 'ransack'
gem 'slack-notifier'
gem 'premailer-rails'
gem 'griddler'
gem 'griddler-mailgun'
gem 'rollbar'
gem 'simplecov', :require => false, :group => :test
gem "factory_bot_rails", "~> 4.0"
gem 'simple_form', '~> 4.1'
gem 'cocoon'

gem 'stripe' 
gem 'stripe_event' 
gem 'stripe-ruby-mock', '~>  2.5.0', :require => 'stripe_mock' 
gem "figaro"
gem 'omniauth-github'
gem 'github_api' 
gem 'mixpanel-ruby'


