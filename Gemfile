
 source 'https://rubygems.org'

 ruby '2.3.0'

 # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
 gem 'rails', '4.2.5'

 # using two different databases for production and for development.
 group :production do
   gem 'pg'
   gem 'rails_12factor'
 end

 #development environment database
 group :development do
   gem 'sqlite3'
 end

#designating rspec and the version for testing
 group :development, :test do
   gem 'rspec-rails', '~>3.0'
   gem 'shoulda'
   gem "factory_girl_rails", "~> 4.0"
 end

 # Use SCSS for stylesheets
 gem 'sass-rails', '~> 5.0'
 # Use Uglifier as compressor for JavaScript assets
 gem 'uglifier', '>= 1.3.0'
 # Use CoffeeScript for .coffee assets and views
 gem 'coffee-rails', '~> 4.1.0'
 # Use jquery as the JavaScript library
 gem 'jquery-rails'
 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
 gem 'turbolinks'

 #Use Bootstrap
 gem 'bootstrap-sass'

 #Used for encrypting user passwords
 gem 'bcrypt'

 #Used for handling sensitive data with environment variables
 gem 'figaro', '1.0'
