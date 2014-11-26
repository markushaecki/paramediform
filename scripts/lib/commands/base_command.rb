class BaseCommand < Struct.new(:settings, :api, :logger)

  def initialize(settings, api, logger)
    super

    # entities will use the api registered here
    self.wire_api [Institute, News]
  end

  def corporate_url
    self.settings['corporate_url']
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
      self.api.default_params auth_token: token
    end

    token
  rescue Exception => e
    Exception.new(%(Unable to get a session from "#{url}", reason: #{e.message}))
    raise e
  end

  def wire_api(classes)
    classes.each do |klass|
      klass.api = self.api
    end
  end

end
