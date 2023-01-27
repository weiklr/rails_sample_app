source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'active_storage_validations', '0.9.6'
gem 'bcrypt',                     '3.1.16'
gem 'bootsnap',                   '1.10.3', require: false
gem 'bootstrap-sass',             '3.4.1'
gem 'bootstrap-will_paginate',    '1.0.0'
gem 'faker',                      '2.19.0'
gem 'image_processing',           '1.12.2'
gem 'jbuilder',                   '2.11.5'
gem 'mini_magick',                '4.11.0'
gem 'puma',                       '5.6.2'
gem 'rails',                      '6.0.3.4'
gem 'sass-rails',                 '6.0.0'
gem 'turbolinks',                 '5.2.1'
gem 'webpacker',                  '5.4.3'
gem 'will_paginate',              '3.3.1'

group :development, :test do
  gem 'byebug',  '11.1.3', platforms: %i[mri mingw x64_mingw]
  gem 'sqlite3', '1.4.2'
end

group :development do
  gem 'listen',                '3.7.1'
  gem 'spring',                '2.1.1'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console',           '4.2.0'
end

group :test do
  gem 'capybara',                 '3.36.0'
  gem 'guard',                    '2.16.2'
  gem 'guard-minitest',           '2.4.6'
  gem 'minitest',                 '5.15.0'
  gem 'minitest-reporters',       '1.5.0'
  gem 'rails-controller-testing', '1.0.5'
  gem 'selenium-webdriver',       '4.1.0'
  gem 'webdrivers',               '5.0.0'
end

group :production do
  gem 'aws-sdk-s3', '1.119.0', require: false
  gem 'pg',         '1.3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# Uncomment the following line if you're running Rails
# on a native Windows system:
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
