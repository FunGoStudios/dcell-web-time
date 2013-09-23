require 'celluloid'

class Clock
  include Celluloid

  def time
    "The time is: #{Time.now}"
  end
end
