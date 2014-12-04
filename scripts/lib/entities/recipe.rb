require File.dirname(__FILE__) + '/extensions/api.rb'

class Recipe < Struct.new(:title, :preparation, :ingredient_slugs, :slug)

  include Entities::Extensions::Api

  attr_accessor :ingredients

  def content
    [preparation, ingredients.map(&:name)].flatten.join(' ')
  end

  def self.build(attributes)
    self.new(attributes['title'], attributes['preparation'], attributes['ingredients'], attributes['_slug'])
  end

end
