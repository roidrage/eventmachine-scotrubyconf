require 'rubygems'
require 'eventmachine'
require 'em-http'
require 'em-redis'
require 'json'

EM.run do
#  redis = EM::Protocols::Redis.connect
  req = EventMachine::HttpRequest.new('http://jsonip.com/').get
  req.callback {
    puts req.response
    ip = JSON.parse(req.response)["ip"]
     redis.set("ip", ip) do |response|
       EM::Protocols::SmtpClient.send(
         :from => "meyer@paperplanes.de",
         :to => ["dhh@rails.com"],
         :header => {"Subject" => "My god, it's full of callbacks!"},
         :body => "This is the body of the email"
       ).callback do
         puts 'Email sent!'
       end
     end
  }
end
