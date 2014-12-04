class IllustrativeText < Struct.new(:_id, :title, :slug, :text)

  include Entities::Extensions::Api

  def content
    text
  end

  def self.build(attributes = {})
    self.new(
      attributes['_id'],
      attributes['title'],
      attributes['_slug'],
      attributes['text'])
  end

end
