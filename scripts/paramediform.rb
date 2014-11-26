#!/usr/bin/env ruby

require 'yaml'
require 'thor'
require 'locomotive/mounter'

require File.dirname(__FILE__) + '/lib/simple_logger.rb'

class ParaMediFormCLI < Thor

  class_option :trace, type: :boolean, default: false

  desc 'post_to_twitter ENV', 'Post once the news from the institutes to Twitter. ENV can be either development (default) or production.'
  def post_to_twitter(env = 'development')
    require File.dirname(__FILE__) + '/lib/commands/post_to_twitter_command.rb'

    command = PostToTwitterCommand.new(load_settings(env), engine_api, logger)
    command.run
  rescue Exception => e
    handle_exception(e)
  end

  desc 'index_contents ENV', 'Copy the searchable contents from the institues to the corporate website. ENV can be either development (default) or production.'
  def index_contents(env = 'development')
    require File.dirname(__FILE__) + '/lib/commands/index_contents_command.rb'

    command = IndexContentsCommand.new(load_settings(env), engine_api, logger)
    command.run
  rescue Exception => e
    handle_exception(e)
  end

  private

  def handle_exception(e)
    logger.error "Error: #{e.message}"
    if options[:trace]
      logger.info "Backtrace:".colorize(color: :red) + "\n\t#{e.backtrace.join("\n\t")}"
    end
  end

  def load_settings(env)
    path = File.join(File.dirname(__FILE__), 'settings.yml')
    all_settings = YAML.load_file(path)
    all_settings[env]
  end

  def logger
    @logger ||= SimpleLogger.new
  end

  def engine_api
    Locomotive::Mounter::EngineApi
  end

end

ParaMediFormCLI.start(ARGV)
