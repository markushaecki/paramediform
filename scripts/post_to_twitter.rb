#!/usr/bin/env ruby

# require 'twitter'
require 'httparty'
require 'locomotive/mounter'
require 'active_support/core_ext/object/blank'

# Questions:
#   1. What to tweet?
#   2. Languages?

class ScriptConfig < Struct.new(:corporate_url, :engine_api_key, :twitter_consumer_key, :twitter_consume_secret, :twitter_access_token, :twitter_access_secret)

  def valid?
    corporate_url.present? &&
    engine_api_key.present? &&
    twitter_consumer_key.present? &&
    twitter_consume_secret.present? &&
    twitter_access_token.present? &&
    twitter_access_secret.present?
  end

  # Set up a new Twitter rest client
  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = twitter_consumer_key
      config.consumer_secret     = twitter_consume_secret
      config.access_token        = twitter_access_token
      config.access_token_secret = twitter_access_secret
    end
  end

  def ask_engine_for_token(url = nil)
    url ||= corporate_url
    @token = Locomotive::Mounter::EngineApi.set_token(uri: "#{url}/locomotive/api", api_key: engine_api_key)
  end

end

class Institute < Struct.new(:name, :url)

  def self.all
    response = Locomotive::Mounter::EngineApi.get('/content_types/institutes/entries.json')

    if response.success?
      response.parsed_response.map do |attributes|
        self.new(attributes['name'], attributes['url'])
      end
    else
      []
    end
  end

end

class UnTweetedNews < Struct.new(:_id, :title)

  def post!(twitter_client)
    puts "Tweet #{title}"

    # post to Twitter
    twitter_client.update("We've got another news #{title}!")

    # toggle the tweeted flag so that the news does not get tweeted twice
    Locomotive::Mounter::EngineApi.put("/content_types/news/entries/#{_id}.json", { query: { content_entry: { tweeted: true } } })
  end

  def self.all
    response = Locomotive::Mounter::EngineApi.get('/content_types/news/entries.json', { query: { where: '{"tweeted":false}' } })

    if response.success?
      response.parsed_response.map do |attributes|
        self.new(attributes['_id'], attributes['_label'])
      end
    else
      []
    end
  end

end

def main
  config = ScriptConfig.new(
    ENV['CORPORATE_URL'],
    ENV['ENGINE_API_KEY'],
    ENV['TWITTER_CONSUMER_KEY'],
    ENV['TWITTER_CONSUMER_SECRET'],
    ENV['TWITTER_ACCESS_TOKEN'],
    ENV['TWITTER_ACCESS_SECRET'])

  raise 'Missing ENV settings' unless config.valid?

  config.ask_engine_for_token

  Institute.all.each do |institute|
    config.ask_engine_for_token(institute.url)

    UnTweetedNews.all.each do |news|
      news.post!(config.twitter_client)
    end
  end
end

main