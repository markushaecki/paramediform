require File.dirname(__FILE__) + '/base_command.rb'

class IndexContentsCommand < BaseCommand

  def run
    logger.log "[IndexContentsCommand] run!", :white, :blue

    # open a session to the main site
    self.authenticate

    Institute.all.each do |institute|
      logger.log_action 'processing', institute.name

      # Index all the news
      self.index_news(institute)

      # Index all the success stories
      # TODO

      # Index all the team members
      # TODO
    end
  end

  def index_news(institute)
    # open a different session for the institute
    self.authenticate(institute.url)

    News.all.each do |news|
      logger.info "\t#{news.title}"

      # TODO: based on the type, get the full news

      # TODO: build a string storing all the searchable elements of the news

      # TODO: build the url

      # TODO: create the index_content document
    end
  end

end
