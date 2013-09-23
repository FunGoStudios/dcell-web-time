require 'celluloid'

class Orologio
  include Celluloid

  def time
    "Ora corrente: #{Time.now}"
  end
end
