require File.dirname(__FILE__) + '/extensions/api.rb'

class TeamMember < Struct.new(:name, :position, :keynote, :slug)

  include Entities::Extensions::Api

  def title
    name
  end

  def content
    [position, keynote].compact.join(' ')
  end

  def self.build(attributes)
    self.new(
      attributes['name'],
      attributes['title'],
      attributes['keynote'],
      attributes['_slug'])
  end

end
