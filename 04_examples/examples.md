!SLIDE bullets incremental

## Echo Server ##

* The "Hello, World" of Network Servers

!SLIDE small

    EM.start_server '127.0.0.1', 8081 do |conn|
      def conn.receive_data(data)
        send_data(data)
      end
    end

!SLIDE bullets incremental

## Pesky callbacks ##
* Put servers into modules

!SLIDE small

    module Echo
      def receive_data(data)
        send_data(data)
      end
    end

    EM.start_server '127.0.0.1', 8081, Echo

!SLIDE

## Don't forget to wrap it in 
## `EM.run {}` ##

!SLIDE bullets incremental

# Protocol Support #

* HTTP
* SMTP
* Memcache
* Redis
* MySQL
* PostgreSQL

!SLIDE bullets incremental

## EventMachine in Real Life ##

* Fetch my IP

!SLIDE smaller

    EM::HttpRequest.new('http://jsonip.com/').get do |req|
      req.callback do
        req.response
      end
    end

!SLIDE

## Parse the IP ##

!SLIDE smaller

    EM::HttpRequest.new('http://jsonip.com/').get do |req|
      req.callback do
        ip = JSON.parse(req.response)["ip"]
      end
    end
!SLIDE

## Store it in Redis ##

!SLIDE smaller

    redis = EM::Protocols::Redis.connect
    EM::HttpRequest.new('http://jsonip.com/').get do |req|
      req.callback do
        ip = JSON.parse(req.response)["ip"]
        redis.set("ip", ip) do |response|
        end
      end
    end

!SLIDE

## Now send an Email ##

!SLIDE even-smaller

    redis = EM::Protocols::Redis.connect
    EM::HttpRequest.new('http://jsonip.com/').get do |req|
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
    end

!SLIDE center

![My God, it's full of callbacks!](callbacks.jpg)

## My God, it's full of callbacks! ##

!SLIDE even-smaller

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

    require 'fiber'

!SLIDE smaller

## HTTP using Fibers ##

    f = Fiber.current

    request = EM::HttpRequest.new('http://jsonip.com').get
    request.callback {f.resume(request)}
    request.errback  {f.resume(request)}

    puts Fiber.yield.response

!SLIDE smaller

## Wrap in a new Fiber ##

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

    EM.synchrony do
      page = EM::HttpRequest.new("http://jsonip.com").get
      ip = JSON.parse(page.response)["ip"]
      redis = EventMachine::Protocols::Redis.connect
      redis.set("ip", ip)
    end
