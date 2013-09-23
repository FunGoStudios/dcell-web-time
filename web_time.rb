require 'rack'
require 'yaml'

begin
  DCELL = YAML.load_file('dcell.yml')
rescue
  puts 'DCell configuration required, see dcell.example.yml'
  exit 1
end

require 'dcell'
DCell.start :id => DCELL['id'], :addr => DCELL['addr'], :directory => DCELL['directory'], :registry => DCELL['registry']

class WebTime
  def call(env)
    req = Rack::Request.new(env)
    lang = req.path.gsub('/', '')
    actor = nil
    
    case lang
    when 'it'
      actor = DCell::Global[:orologio]
    when 'en'
      actor = DCell::Global[:clock]
    when 'all'
      return [200, {'Content-Type' => 'text/plain'}, [DCell::Node.all.inspect]]
    else
      return [404, {'Content-Type' => 'text/plain'}, ['Lang not supported']]
    end

    [200, {'Content-Type' => 'text/plain'}, ["#{actor.time}"]]
  end
end
