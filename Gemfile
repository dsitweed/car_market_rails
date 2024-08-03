source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.2.2"
gem "importmap-rails"
gem "jbuilder"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem "redis", "~> 4.0"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem "turbo-rails"
# gem "kredis"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
# gem "image_processing", "~> 1.2"
gem "bootstrap-sass"
gem "faker"
gem "font-awesome-sass"
gem "sassc-rails"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i(mri mingw x64_mingw)
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem "capybara",                 "3.37.1"
  gem "guard",                    "2.18.0"
  gem "guard-minitest",           "2.4.6"
  gem "minitest",                 "5.15.0"
  gem "minitest-reporters",       "1.5.0"
  gem "rails-controller-testing", "1.0.5"
  gem "selenium-webdriver",       "4.2.0"
  gem "webdrivers",               "5.0.0"
end
