!SLIDE bullets incremental

# I/O Workflows #

* Open a socket
* Read/write to socket
* Wait for it
* Rinse and repeat

!SLIDE smaller

    @@@ruby
    require 'socket'
    server = TCPServer.new(2202)

    while client = server.accept
      msg = client.readline
      client.write msg
      client.close
    end

!SLIDE bullets incremental

# Rails Workflow #

* Request comes in
* Ask the database
* Wait for it
* Render the response

!SLIDE center

![It's going to be legendary](waitforit.jpg)

# Wait for it... #

!SLIDEl

## ZOMG, SO MUCH WAITING!!! ##

!SLIDE

## I/O blocks the flow ##

!SLIDE

## Nothing else can run ##

!SLIDE

## Threads? ##

!SLIDE small

    @@@ ruby
    while true
      Thread.new(server.accept) do |client|
        msg = client.readline
        client.write msg
        client.close
      end
    end

!SLIDE

## Possible, But Meh. ##

!SLIDE

## More I/O than CPU ##

!SLIDE

## That's just not right ##

!SLIDE

## No [C10K](http://www.kegel.com/c10k.html) for you ##

!SLIDE bullets

## They do it, we should too ##

* nginx
* Redis
* Memcached
* Thin

!SLIDE center

# Why Evented I/O?

!SLIDE bullets incremental

## Lots of things are I/O bound ##

* little processing involved (CPU)

!SLIDE bullets incremental small

* Proxies
* Transferring (not uploading) files
* (Almost-)real time apps
* Streaming/Firehose APIs
* Messaging
* Publish/Subscribe
* Simple APIs
* Network Servers (and Clients)

!SLIDE bullets incremental

# Why? #

* Throughput more important than processing

!SLIDE

## Parallelism in Ruby sucks ##

!SLIDE

## What we really want ##

!SLIDE center

![Hollywood](hollywood.jpg)

## Don't call us, we'll call you. ##
