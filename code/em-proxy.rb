require 'eventmachine'
require 'proxymachine'

EM.run do
    queue = EM::Queue.new
    EM.add_periodic_timer(1) do
      queue.pop do |msg|
        puts "Popped #{msg}"
      end
    end

    EM.add_periodic_timer(1) do
      queue.push("ZOMG, MESSAGE!!")
    end
end
