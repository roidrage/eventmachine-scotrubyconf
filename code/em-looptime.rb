require 'eventmachine'

EM.run do
  time = proc do
    now = Time.now
    puts "#{now.tv_sec}.#{now.tv_usec}"
    EM.next_tick &time
  end
  EM.next_tick &time
end
