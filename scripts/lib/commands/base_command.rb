class BaseCommand < Struct.new(:settings, :api, :logger)

  attr_accessor :section_urls

  def initialize(settings, api, logger)
    super

    self.section_urls = {}

    # entities will use the api registered here
    self.wire_api :institute, :news, :illustrative_text,
      :indexed_content, :person,
      :interview, :interview_question,
      :recipe, :recipe_ingredient,
      :success_story, :team_member
  end

  def corporate_url
    self.settings['corporate_url']
  end

  def institute_section_url(institute_slug, slug, type)
    if template = self.section_urls[type]
      template.gsub(':institute_slug', institute_slug)
        .gsub(':slug', slug)
        .gsub(':type', type.to_s)
    else
      _institute_section_url(institute_slug, slug, type).tap do |_url|
        self.section_urls[type] = _url.gsub(institute_slug, ':institute_slug')
          .gsub(slug, ':slug')
          .gsub(type.to_s, ':type')
      end
    end
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

  protected

  def _institute_section_url(institute_slug, slug, type)
    url   = "#{self.corporate_url}/local-api/institute-section-url.json"
    query = { institute_slug: institute_slug, slug: slug, type: type }

    HTTParty.get(url, query: query)['url']
  end

end
