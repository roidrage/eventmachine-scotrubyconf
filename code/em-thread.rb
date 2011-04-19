require 'rubygems'
require 'mechanize'
require 'eventmachine'

trap("INT") {EM.stop}

EM.run do 
  num = 0
  operation = proc {
    agent = Mechanize.new
    sleep 1
    agent.get("http://google.com").body.to_s.size
    sleep 1
  }
  callback = proc { |result|
    puts result
    num+=1
    EM.stop if num == 9
  }

  10.times do 
    EventMachine.defer operation, callback
  end
end
