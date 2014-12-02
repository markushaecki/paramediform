require File.dirname(__FILE__) + '/extensions/api.rb'

class Institute < Struct.new(:name, :url, :slug)

  include Entities::Extensions::Api

  def self.build(attributes)
    self.new(attributes['name'], attributes['url'], attributes['_slug'])
  end

end
