source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'
gem 'rails', '>= 6.1.2.1'

gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '~> 1.2'

gem 'devise'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0.0'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
