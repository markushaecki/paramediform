class PushAllCommand < Struct.new(:institute_path, :logger)

  def initialize(institute_path, logger)
    super
    self.institute_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', institute_path))
  end

  def run
    logger.log "[PushAllCommand] run!", :white, :blue
    deploy_envs.each do |env|
      push_to(env.first)
    end
  end

  def push_to(name)
    logger.wait_spinner('Pushing to', name) do
      `cd #{institute_path}; wagon push #{name}; cd -`
    end
    
    logger.success 'done:'
  end

  def deploy_envs
    path = File.join(institute_path, 'config', 'deploy.yml')
    YAML.load_file(path)
  end

end
