require File.dirname(__FILE__) + '/extensions/api.rb'

class IndexedContent < Struct.new(:title, :institute, :content, :url)

  include Entities::Extensions::Api

  def self.build(attributes)
    self.new(
      attributes['title'] || attributes[:title],
      attributes['institute'] || attributes[:institute],
      attributes['content'] || attributes[:content],
      attributes['url'] || attributes[:url])
  end

  def attributes
    { title: self.title, content: content, url: url, institute: institute }
  end

end
