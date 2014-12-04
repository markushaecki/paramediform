class BaseCommand < Struct.new(:settings, :api, :logger)

  def initialize(settings, api, logger)
    super

    # entities will use the api registered here
    self.wire_api :institute, :news, :illustrative_text,
      :indexed_content, :person,
      :interview, :interview_question,
      :recipe, :recipe_ingredient
  end

  def corporate_url
    self.settings['corporate_url']
  end

  def news_url(institute_slug, slug, type)
    if @news_template.blank?
      url   = "#{self.corporate_url}/local-api/news-url.json"
      query = { institute_slug: institute_slug, slug: slug, type: type }

      return HTTParty.get(url, query: query)['url'].tap do |news_url|
        @news_template = news_url.gsub(institute_slug, ':institute_slug')
          .gsub(slug, ':slug')
          .gsub(type.to_s, ':type')
      end
    end

    @news_template.gsub(':institute_slug', institute_slug)
      .gsub(':slug', slug)
      .gsub(':type', type.to_s)
  end

  def engine_api_key
    self.settings['engine_api_key']
  end

  def authenticate(url = nil)
    url     ||= self.corporate_url
    @tokens ||= {}

    if (token = @tokens[url]).nil?
      token = self.api.set_token(uri: "#{url}/locomotive/api", api_key: self.engine_api_key)
      @tokens[url] = token
    else
      self.api.base_uri "#{url}/locomotive/api"
      self.api.default_params auth_token: token
    end

    token
  rescue Exception => e
    Exception.new(%(Unable to get a session from "#{url}", reason: #{e.message}))
    raise e
  end

  def wire_api(*entities)
    entities.each do |name|
      require File.dirname(__FILE__) + "/../entities/#{name}.rb"
      klass = name.to_s.camelize.constantize
      klass.api = self.api
    end
  end

end
