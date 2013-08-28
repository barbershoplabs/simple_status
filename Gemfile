source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'unicorn', '4.6.3' # rack http server
gem 'jbuilder', '~> 1.2'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'rails_12factor'

gem 'jquery-rails'
gem 'turbolinks'
# gem 'jquery-turbolinks'
gem "twitter-bootstrap-rails"
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'cocoon'
gem 'tod'

gem 'devise'
gem 'devise_invitable', :github => 'scambra/devise_invitable'
gem 'stripe'
gem 'cancan'
gem 'mailgun'

group :doc do
  gem 'sdoc', require: false
end

group :development do
	gem 'mysql2'
  gem 'quiet_assets'
end

group :development, :test do
	gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl_rails', '~> 4.0'
end

group :test do
  gem 'debugger'
  gem 'capybara'
	gem 'selenium-webdriver'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
end
