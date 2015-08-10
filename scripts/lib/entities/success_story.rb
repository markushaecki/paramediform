require File.dirname(__FILE__) + '/extensions/api.rb'

class SuccessStory < Struct.new(:title, :prename, :name, :place, :lost_weight, :feeling_of_abdiction, :experience, :slug)

  include Entities::Extensions::Api

  def content
    [title, prename, name, place, lost_weight, feeling_of_abdiction, experience].compact.join(' ')
  end

  def self.build(attributes)
    self.new(
      attributes['experience_title'],
      attributes['prename'],
      attributes['name'],
      attributes['place'],
      attributes['lost_weight'],
      attributes['feeling_of_abdiction'],
      attributes['experience'],
      attributes['_slug'])
  end

end
