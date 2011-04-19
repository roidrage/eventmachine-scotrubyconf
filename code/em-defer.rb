require 'eventmachine'

EM.run do
  EM.add_periodic_timer(1) do
    puts "ping"
  end
  EM.defer do
    puts "sleep"
    sleep 5
    puts "done"
  end
end
