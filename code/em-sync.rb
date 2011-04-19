require 'json'
require 'em-synchrony'
require "em-synchrony/em-http"
require "em-synchrony/em-redis"

EM.run do
  EM.synchrony do
    page = EventMachine::HttpRequest.new("http://jsonip.com").get
    ip = JSON.parse(page.response)["ip"]
    redis = EventMachine::Protocols::Redis.connect
    redis.set("ip", ip)
  end
end
