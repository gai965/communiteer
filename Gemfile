source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'


gem 'rails', '~> 6.1.3'
gem 'mysql2', '~> 0.5.3'
gem 'puma', '~> 5.0'

gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # 静的解析ツール
  gem 'rubocop', require: false
  # 自動デプロイ
 gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-rbenv-vars', '~> 0.1'
  gem 'capistrano3-puma'

  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'pry-rails' # デバッグツールgem
gem 'devise'    # ユーザ登録用gem
gem 'faker'
gem 'gimei'     # 日本語版Faker
gem 'mini_magick'
gem 'image_processing', '~> 1.2'
gem 'impressionist'  # PVのgem
gem 'kaminari' #ページネーションのgem
gem "aws-sdk-s3", require: false
