#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'yaml'
require 'thor'
require 'active_support/inflector'
require 'locomotive/mounter'

require File.dirname(__FILE__) + '/lib/simple_logger.rb'

class ParaMediFormCLI < Thor

  class_option :trace, type: :boolean, default: false

  desc 'post_to_twitter ENV', 'Post once the news from the institutes to Twitter. ENV can be either development (default) or production.'
  def post_to_twitter(env = 'development')
    run :post_to_twitter, env
  end

  desc 'index_contents ENV', 'Copy the searchable contents from the institues to the corporate website. ENV can be either development (default) or production.'
  def index_contents(env = 'development')
    run :index_contents, env
  end

  desc 'push_all', 'Deploy all the institutes (but without the data) to the Engine'
  def push_all
    require File.dirname(__FILE__) + "/lib/commands/push_all_command.rb"
    command = PushAllCommand.new(load_settings('institute_path'), logger)
    run_cmd(command)
  end

  private

  def run(name, env)
    require File.dirname(__FILE__) + "/lib/commands/#{name}_command.rb"

    klass = "#{name.to_s.camelize}Command".constantize
    command = klass.new(load_settings(env), engine_api, logger)

    run_cmd(command)
  end

  def run_cmd(command)
    benchmark { command.run }
  rescue Exception => e
    handle_exception(e)
  end

  def benchmark(&block)
    start_at = Time.now.to_f

    block.call

    ellapsed_time = (Time.now.to_f - start_at) * 1000

    logger.log "\n" + "Processed in #{ellapsed_time} ms".colorize(:green)
  end

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
