!SLIDE bullets incremental

## Echo Server ##

* The "Hello, World" of Network Servers

!SLIDE small

    @@@ ruby
    EM.start_server '127.0.0.1', 8081 do |conn|
      def conn.receive_data(data)
        send_data(data)
      end
    end

!SLIDE

## No Boilerplate Networking Code ##

!SLIDE bullets incremental

## Pesky callbacks ##
* Put servers into modules

!SLIDE small

    @@@ ruby
    module Echo
      def receive_data(data)
        send_data(data)
      end
    end

    EM.start_server '127.0.0.1', 8081, Echo

!SLIDE

## Echo Client ##

!SLIDE smaller

    @@@ruby
    module EchoClient
      def post_init
        send_data "hello world"
      end

      def receive_data(data)
        puts "Received #{data}"
      end
    end

    EM.connect '127.0.0.1', 8081, EchoClient

!SLIDE

## Don't forget to wrap it in 
## `EM.run {}` ##

!SLIDE

## HTTP Server ##

!SLIDE even-smaller

    @@@ ruby
    require 'eventmachine'
    require 'evma_httpserver'

    class HelloWorldServer < EventMachine::Connection
      include EventMachine::HttpServer

      def process_http_request
        response = EventMachine::DelegatedHttpResponse.new(self)
        response.status = 200
        response.content = "Hello, world!"
        response.content_type "text/plain"
        response.send_response
      end
    end

    EM.run do
      EM.start_server '127.0.0.1', 8080, HelloWorldServer
    end

!SLIDE

# Protocol Support #

!SLIDE bullets incremental

* HTTP
* SMTP
* Memcache
* Redis
* MySQL
* PostgreSQL
* [...]()

!SLIDE bullets incremental

## EventMachine in Real Life ##

* Fetch my IP

!SLIDE

## [em-http-request](http://github.com/igrigorik/em-http-request) ##

!SLIDE smaller

    @@@ ruby
    req = EM::HttpRequest.new('http://jsonip.com/').get
    req.callback do
      puts req.response
    end

!SLIDE

## Parse the IP ##

!SLIDE smaller

    @@@ ruby
    req = EM::HttpRequest.new('http://jsonip.com/').get
    req.callback do
      ip = JSON.parse(req.response)["ip"]
    end

!SLIDE

## Store it in Redis ##

!SLIDE smaller

    @@@ruby
    redis = EM::Protocols::Redis.connect
    req = EM::HttpRequest.new('http://jsonip.com/').get
    req.callback do
      ip = JSON.parse(req.response)["ip"]
      redis.set("ip", ip) do |response|
      end
    end

!SLIDE

## Now send an Email ##

!SLIDE even-smaller

    @@@ruby
    redis = EM::Protocols::Redis.connect
    req = EM::HttpRequest.new('http://jsonip.com/').get do |req|
    req.callback do
      ip = JSON.parse(req.response)["ip"]
      redis.set("ip", ip) do |response|
        EM::Protocols::SmtpClient.send(
          :from => "meyer@paperplanes.de",
          :to => ["dhh@rails.com"],
          :header => {"Subject" => "It's full of callbacks!"},
          :body => "Look at this code, man!"
        ).callback do
          puts 'Email sent!'
        end
      end
    end

!SLIDE center

![My God, it's full of callbacks!](callbacks.jpg)

## My God, it's full of callbacks! ##

!SLIDE even-smaller

    @@@javascript
    http.get({host: 'jsonip.com'}, function(res) {
      var data = '';
      res.on('data', function(chunk) {
        data += chunk;
      });
      res.on('end', function() {
        var ip = JSON.parse(data)["ip"];
        redis.set("ip", ip, function(error, output) {
          email.send({
            to : "javascript@gmail.com",
            from : "meyer@paperplanes.de",
            subject : "Curly braces everywhere!",
          },
          function(err, result){
            console.log("Email sent!");
          }); 
        });
      });
    })

!SLIDE center

![Cadbury World](cadbury-world.jpg)

## Wouldn't it be nice... ##

!SLIDE smaller

    @@@ruby
    page = EM::HttpRequest.new("http://jsonip.com").get
    ip = JSON.parse(page.response)["ip"]
    redis = EM::Protocols::Redis.connect
    redis.set("ip", ip)

!SLIDE

# Fibers! #

!SLIDE center

![Ruby 1.8](fuuuuuu.jpg)

# No More Ruby 1.8 #

!SLIDE

# Ruby 1.9 #

!SLIDE

## "Lightweight Concurrency" ##

!SLIDE

    @@@ruby
    require 'fiber'

!SLIDE smaller

## HTTP using Fibers ##

    @@@ruby
    f = Fiber.current

    request = EM::HttpRequest.new('http://jsonip.com').get
    request.callback {f.resume(request)}
    request.errback  {f.resume(request)}

    puts Fiber.yield.response

!SLIDE smaller

## Wrap in a new Fiber ##

    @@@ruby
    Fiber.new do
      f = Fiber.current
      request = EM::HttpRequest.new('http://jsonip.com').get
      request.callback {f.resume(request)}
      request.errback  {f.resume(request)}
      puts Fiber.yield.response
    end.resume

!SLIDE

# [em-synchrony](http://github.com/igrigorik/em-synchrony) #

!SLIDE smaller

    @@@ruby
    EM.synchrony do
      page = EM::HttpRequest.new("http://jsonip.com").get
      ip = JSON.parse(page.response)["ip"]
      redis = EventMachine::Protocols::Redis.connect
      redis.set("ip", ip)
    end

!SLIDE

## Fibers: Whoa! ##
