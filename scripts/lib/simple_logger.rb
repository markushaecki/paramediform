require 'colorize'

class SimpleLogger

  def log(message, color = nil, background = nil)
    output = color.nil? ? message : message.colorize(color: color, background: background)
    puts output
  end

  def info(message)
    self.log message
  end

  def log_action(action, message)
    self.log action.colorize(mode: 'underline') + " " + message
  end

  def error(message)
    self.log message, :white, :red
  end

end
