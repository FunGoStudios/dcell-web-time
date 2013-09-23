require 'rack'

def usage
  puts 'actor-node <ID> <ADDR> <CLUSTER-ID> <CLUSTER-ADDR>'
end

if ARGV.size != 4
  usage
  exit 1
end

require 'dcell'

id = ARGV[0]
addr = ARGV[1]
cluster_id = ARGV[2]
cluster_addr = ARGV[3]
DCell.start :id => id, :addr => addr, :directory => {:id => cluster_id, :addr => cluster_addr}

class WebTime
  def call(env)
    req = Rack::Request.new(env)
    lang = req.path.gsub('/', '')
    time = DCell::Global[lang.to_sym]
    if time.nil?
      return [404, {'Content-Type' => 'plain/text'}, ['Lang not supported']]
    end

    time = time.time
    [200, {'Content-Type' => 'plain/text'}, ["#{time}"]]
  end
end
