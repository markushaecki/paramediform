source 'https://rubygems.org'

gem 'locomotivecms_wagon', github: 'locomotivecms/wagon', ref: '2fe2b89'
gem 'locomotivecms_steam', github: 'locomotivecms/steam', ref: 'e0abf4c'

group :development do
  # Mac OS X
  gem 'rb-fsevent', '~> 0.9.1', require: RUBY_PLATFORM.include?('darwin') && 'rb-fsevent'

  # Unix
  gem 'therubyracer', require: 'v8', platforms: :ruby unless RUBY_PLATFORM.include?('darwin')
  gem 'rb-inotify', '~> 0.9', require: RUBY_PLATFORM.include?('linux') && 'rb-inotify'

  # Windows
  gem 'wdm', '>= 0.1.0', require: RUBY_PLATFORM =~ /mswin|mingw/i && 'wdm'
end

group :misc do
  # Add your extra gems here
  # gem 'susy', require: 'susy'
  # gem 'redcarpet', require: 'redcarpet'
end
