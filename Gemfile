source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# add internalization
# wrapper on datatables for server side processing
gem 'ajax-datatables-rails', '=1.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem "pry-rails"
# Use mysql as the database for Active Record
gem 'sassc', '~> 2.1.0'
gem 'mysql2', '~> 0.5'
# Use devise for authentication
gem 'devise', '=4.8.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '=5.4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# pagination
gem 'will_paginate', '= 3.3.1'
# gems for sequence of ids
gem 'sequenceid', '=0.0.7', git: "https://github.com/alisyed/sequenceid.git", branch: 'feature/change_activerecord_base_to_applicationrecord_in_sti_parent_class_method'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# Use cancancan for restricitng user access to resources
gem 'cancancan', '= 3.3.0'
# Use audit for maintaining histories of issues
gem 'audited', '= 5.0'
# gem to create charts and graphs
gem 'chartkick', '=4.0.5'
# use delayed job to send emails using a background job
gem 'delayed_job_active_record', '=4.1.6'
# gem to search in global context
gem 'searchkick', '=4.6.0'
# gem to add run time functions
gem 'draper', '=4.0.2'
# gem to display path
gem 'breadcrumbs_on_rails', '=4.1.0'
# gem to add documents
gem 'paperclip', '~> 6.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # binding pry gems for block points
  gem 'pry', '~> 0.14.1'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'faker', '=2.19.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
end
