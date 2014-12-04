require File.dirname(__FILE__) + '/extensions/api.rb'

class InterviewQuestion < Struct.new(:question, :answer, :slug)

  include Entities::Extensions::Api

  def content
    question + ' ' + answer
  end

  def self.build(attributes)
    self.new(attributes['question'], attributes['answer'], attributes['_slug'])
  end

end
