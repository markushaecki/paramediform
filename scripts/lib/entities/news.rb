require File.dirname(__FILE__) + '/extensions/api.rb'

class News < Struct.new(:_id, :title, :slug, :type)

  include Entities::Extensions::Api

  attr_accessor :url

  def message
    "#{self.title} #{self.url}"
  end

  def post!(twitter_client)
    # post to Twitter
    begin
      twitter_client.update(self.message)
      true
    rescue Exception => e
      raise Exception.new('Unable to update the message on Twitter')
    end

    # toggle the tweeted flag so that the news does not get tweeted twice
    self.api.update('content_types/news/entries', _id, { tweeted: true })
  end

  def self.untweeted
    entries = self.api.fetch('content_types/news/entries', { where: '{"tweeted":false}' })

    [].tap do |list|
      entries.each do |attributes|
        list << self.new(attributes['_id'], attributes['_label'], attributes['_slug'], detect_type(attributes))
      end
    end
  end

  def self.detect_type(attributes)
    if attributes['interview']
      'interview'
    elsif attributes['recipe']
      'recipe'
    elsif attributes['illustrative_text']
      'illustrative_text'
    else
      nil
    end
  end

end
