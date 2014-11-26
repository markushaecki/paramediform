require File.dirname(__FILE__) + '/../entities/institute.rb'
require File.dirname(__FILE__) + '/../entities/news.rb'
require File.dirname(__FILE__) + '/base_command.rb'

require 'twitter'

class PostToTwitterCommand < BaseCommand

  attr_writer :twitter_client

  def run
    logger.log "[PostToTwitterCommand] run!", :white, :blue

    # open a session to the main site
    self.authenticate

    Institute.all.each do |institute|
      logger.log_action 'processing', institute.name

      self.tweet_all_untweeted_news(institute)
    end
  end

  def tweet_all_untweeted_news(institute)
    # open a different session for the institute
    self.authenticate(institute.url)

    News.untweeted.each do |news|
      news.url = news_url(institute.slug, news.slug, news.type)

      logger.log_action "\ttweeting", %("#{news.message}")

      news.post!(twitter_client)
    end
  end

  # Set up a new Twitter rest client
  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = twitter_config(:consumer_key)
      config.consumer_secret     = twitter_config(:consumer_secret)
      config.access_token        = twitter_config(:access_token)
      config.access_token_secret = twitter_config(:access_token_secret)
    end
  end

  def twitter_config(key)
    self.settings['twitter'][key.to_s]
  end

  def news_url(institute_slug, slug, type)
    url   = "#{self.corporate_url}/local-api/news-url.json"
    query = { institute_slug: institute_slug, slug: slug, type: type }

    HTTParty.get(url, query: query)['url']
  end

end
