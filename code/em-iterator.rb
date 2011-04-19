require 'eventmachine'

EM.run do
  i = 0
  block = proc do
    if i < 100
      i += 1
      puts "Off to the next tick"
      EM.next_tick &block
    end
  end
  EM.next_tick &block
end
