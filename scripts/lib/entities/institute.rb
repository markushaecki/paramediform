require File.dirname(__FILE__) + '/extensions/api.rb'

class Institute < Struct.new(:name, :url, :slug)

  include Entities::Extensions::Api

  def self.all
    entries = self.api.fetch('content_types/institutes/entries')

    [].tap do |list|
      entries.each do |attributes|
        list << self.new(attributes['name'], attributes['url'], attributes['_slug'])
      end
    end
  end

end
