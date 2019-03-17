source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'webpacker'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'dotenv-rails'

gem 'aws-sdk-rails'
gem "aws-sdk-s3"

gem "shrine"
gem "tus-server", "~> 2.0"
gem "shrine-tus", "~> 1.0"

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'

gem 'kaminari'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop'
end

group :development do
  gem 'foreman', require: false
  gem 'annotate'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'letter_opener'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'fabrication'
  gem 'faker'
end
