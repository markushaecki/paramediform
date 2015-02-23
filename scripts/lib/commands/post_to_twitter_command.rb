require File.dirname(__FILE__) + '/base_command.rb'

require 'twitter'

class PostToTwitterCommand < BaseCommand

  attr_writer :twitter_client

  def run
    logger.log "[PostToTwitterCommand] run!", :white, :blue

    # open a session to the main site
    self.authenticate

    tweet_all_untweeted_news_from_corporate

    if false # do not tweet institute news
      Institute.all.each do |institute|
        logger.log_action 'processing', institute.name

        self.tweet_all_untweeted_news(institute)
      end
    end
  end

  def tweet_all_untweeted_news_from_corporate
    News.untweeted.each do |news|
      news.url = corporate_url + "/aktuelles?slug=#{news.slug}&type=#{news.type}"

      logger.log_action "\ttweeting", %("#{news.message}")

      news.post!(twitter_client)
    end
  end

  def tweet_all_untweeted_news(institute)
    # open a different session for the institute
    self.authenticate(institute.url)

    News.untweeted.each do |news|
      news.url = institute_section_url(institute.slug, news.slug, news.type)

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
    if _config = self.settings['twitter']
      _config[key.to_s]
    else
      raise 'Missing twitter section in the settings.yml file'
    end
  end

end
