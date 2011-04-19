require 'eventmachine'
EM.run do
  queue = EM::Queue.new
  popper = lambda do |msg|
    puts "Popped #{msg}"
    queue.pop &popper
  end

  queue.pop &popper

  EM.add_periodic_timer(1) do
    queue.push("ZOMG, MESSAGE!!")
  end
end
