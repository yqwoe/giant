source 'https://gems.ruby-china.org'
ruby '2.4.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'jpush'
gem 'will_paginate-bootstrap'
gem 'cancancan'
gem 'pghero'
gem 'pg_query'
gem 'redis'
gem 'redis-namespace'
gem 'swagger-docs'
gem 'bootstrap-datepicker-rails'

group :development do
  gem 'guard-ctags-bundler'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '>= 0.1.1'

  # Remove the following if your server does not use RVM
  gem 'capistrano-rvm'
  # Use Capistrano for deployment
  gem 'capistrano-rails'

  gem 'rails-erd'
  gem 'foreman'

end

gem 'devise'
gem 'pg'

gem 'active_model_serializers', '~> 0.10.0'
gem 'activerecord-import', '~> 0.11.0'

gem 'ruby-pinyin'
gem 'china_sms'
gem 'status-page'

##
# This line for debug
#gem 'alipay', path: '/Users/wangqsh/Code/star/alipay'
#

gem 'alipay', git: 'https://github.com/rocLv/alipay.git'
gem 'ransack'

gem 'json'
gem 'will_paginate', git: 'https://git.coding.net/railstutorial/will_paginate.git'
gem 'wx_pay'

gem 'carrierwave', '~> 1.0'

gem 'sweet-alert', git: 'https://github.com/rocLv/sweet-alert-rails.git'
gem 'sweet-alert-confirm'

gem 'byebug', platform: :mri
group :development, :test do
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'mini_racer', platforms: :ruby
  gem 'pry'

  # pry-doc extends two core pry commands:
  # show-doc, alias ?
  # show-source alias $
  gem 'pry-doc'

  # show-routes
  # show-routes --grep beer
  # show-routes --grep new
  # show-models
  gem 'pry-rails'

  # Usage: binding.pry
  # anywhere
  gem 'pry-rescue'
  gem 'pry-byebug'

  # Color console output
  gem 'rainbow'

  gem 'factory_girl_rails'
  gem 'database_cleaner'

  # Automation test
  gem 'poltergeist'
  gem 'capybara'
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-livereload'

  gem 'simplecov', :require => false

  gem 'mocha'
  gem 'minitest-reporters'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'brakeman'
  gem 'bullet'
  gem "zero_downtime_migrations"
  gem "better_errors"
end

