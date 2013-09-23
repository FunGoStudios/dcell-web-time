require 'dcell'
require './clock.rb'
require './orologio.rb'

def usage
  puts 'actor-node <ID> <ADDR>'
end

if ARGV.size != 2
  usage
  exit 1
end

id = ARGV[0]
addr = ARGV[1]
DCell.start(:id => id, :addr => addr)

Clock.supervise_as :clock
Orologio.supervise_as :orologio
node = DCell::Node[id]
DCell::Global[:clock] = node[:clock]
DCell::Global[:orologio] = node[:orologio]

puts 'Actors are ready to play...'
sleep
