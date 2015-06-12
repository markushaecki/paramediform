require File.dirname(__FILE__) + '/base_command.rb'

class IndexContentsCommand < BaseCommand

  def run
    logger.log "[IndexContentsCommand] run!", :white, :blue

    # open a session to the main site
    self.authenticate

    # reset all the entries
    IndexedContent.destroy_all

    Institute.all.each do |institute|
      logger.log_action 'processing', institute.name

      # Index all the news
      self.index_news(institute)

      # Index all the success stories
      self.index_success_stories(institute)

      # Index all the team members
      self.index_team_members(institute)
    end
  end

  def index_team_members(institute)
    _index_collection(institute, :team_member) do
      TeamMember.all
    end
  end

  def index_success_stories(institute)
    _index_collection(institute, :success_story) do
      SuccessStory.all
    end
  end

  def index_news(institute)
    # illustrative texts
    self.index_illustrative_text(institute)

    # interviews
    #index_interviews(institute)

    # recipes
    #index_recipes(institute)
  end
  
  #def index_recipes(institute)
  #  _index_collection(institute, :recipe) do
  #    Recipe.all.map do |recipe|
  #      # fetch the ingredients
  #      if recipe.ingredient_slugs
  #        recipe.ingredients = recipe.ingredient_slugs.map do |slug|
  #          RecipeIngredient.find(slug)
  #        end
  #      end

  #      recipe
  #    end
  #  end
  #end

  def index_illustrative_text(institute)
    _index_collection(institute, :illustrative_text) do
      IllustrativeText.all
    end
  end

  def index_interviews(institute)
    _index_collection(institute, :interview) do
      Interview.all.map do |interview|
        # fetch the author
        if interview.author_slug
          interview.author = Person.find(interview.author_slug)
        end

        # fetch the questions/answers
        if interview.question_slugs
          interview.questions = interview.question_slugs.map do |slug|
            InterviewQuestion.find(slug)
          end
        end

        interview
      end
    end
  end

  def save(type, collection)
    self.authenticate

    collection.each do |content|
      begin
        logger.log "\t[#{type}] saving....#{content.title}"
        content.save
      rescue Locomotive::Mounter::ApiWriteException => e
        logger.warning e.message
      end
    end
  end

  protected

  def _index_collection(institute, type, &block)
    self.authenticate(institute.url)

    entities = block.call(institute)

    contents = entities.map do |entity|
      build_indexed_content(institute, entity, type)
    end

    save(type, contents) # save all the contents
  end

  def build_indexed_content(institute, entity, type)
    attributes = { title: entity.title, institute: institute.slug, content: entity.content }

    IndexedContent.build(attributes).tap do |content|
      content.url = institute_section_url(institute.slug, entity.slug, type)
    end
  end

end
