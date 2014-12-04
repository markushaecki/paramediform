require File.dirname(__FILE__) + '/extensions/api.rb'

class Interview < Struct.new(:title, :description, :author_slug, :question_slugs, :slug)

  include Entities::Extensions::Api

  attr_accessor :author, :questions

  def content
    [description, author.try(:name), questions.map(&:content)].compact.join(' ')
  end

  def self.build(attributes)
    self.new(attributes['title'], attributes['description'], attributes['person'], attributes['questions'], attributes['_slug'])
  end

end
