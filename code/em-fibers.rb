require 'fiber'
require 'em-http'

EM.run do
  Fiber.new do
    f = Fiber.current
    request = EM::HttpRequest.new('http://jsonip.com').get
    request.callback {f.resume(request)}
    request.errback  {f.resume(request)}
    puts Fiber.yield.response
  end.resume
end
