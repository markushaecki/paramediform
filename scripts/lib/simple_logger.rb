require 'colorize'

class SimpleLogger

  def log(message, color = nil, background = nil, same_line = false)
    output = color.nil? ? message : message.colorize(color: color, background: background)
    if same_line
      print output
    else
      puts output
    end
  end

  def info(message)
    self.log message
  end

  def log_action(action, message, same_line = false)
    self.log action.colorize(mode: 'underline') + " " + message, nil, nil, same_line
  end

  def success(message)
    self.log message, :green
  end

  def error(message)
    self.log message, :white, :red
  end

  def warning(message)
    self.log message, :orange
  end

  # http://stackoverflow.com/questions/10262235/printing-an-ascii-spinning-cursor-in-the-console
  def wait_spinner(action, message, fps = 10)
    log_action(action, message + '...', true)

    chars = %w[| / - \\]
    delay = 1.0/fps
    iter = 0
    spinner = Thread.new do
      while iter do  # Keep spinning until told otherwise
        print chars[(iter+=1) % chars.length]
        sleep delay
        print "\b"
      end
    end
    yield.tap{       # After yielding to the block, save the return value
      iter = false   # Tell the thread to exit, cleaning up after itself...
      spinner.join   # ...and wait for it to do so.
    }                # Use the block's return value as the method's
  end

end
