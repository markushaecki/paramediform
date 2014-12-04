require File.dirname(__FILE__) + '/extensions/api.rb'

class Person < Struct.new(:name)

  include Entities::Extensions::Api

  def self.build(attributes)
    self.new(attributes['name'])
  end

end
