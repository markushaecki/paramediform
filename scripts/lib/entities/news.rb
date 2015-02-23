require 'date'
require File.dirname(__FILE__) + '/extensions/api.rb'

# social_media
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

      # toggle the tweeted flag so that the news does not get tweeted twice
      self.api.update('content_types/news/entries', _id, { tweeted: true })

      true
    rescue Exception => e
      raise Exception.new('Unable to update the message on Twitter')
    end
  end

  def self.untweeted
    self.all '{"tweeted":false,"_visible":true}'
  end

  def self.build(attributes)
    return nil unless self.is_published_news?(attributes)

    self.new(
      attributes['_id'],
      attributes['social_media'],
      attributes['_slug'],
      detect_type(attributes))
  end

  def self.is_published_news?(attributes)
    date = Date.strptime(attributes['published_at'], '%d.%m.%Y')
    date <= Date.today
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
