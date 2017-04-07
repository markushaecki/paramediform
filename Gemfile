source 'https://rubygems.org'

gem 'locomotivecms_mounter', github: 'locomotivecms/mounter', ref: '4c7d971'
gem 'locomotivecms_wagon', '~> 1.5.8'

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
  gem 'locomotivecms_liquid_extensions', github: 'locomotivecms/liquid_extensions'
  gem 'locomotivecms-search-wagon', github: 'Papipo/locomotivecms-search', branch: 'wagon'
end