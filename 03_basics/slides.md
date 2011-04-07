!SLIDE center

![How does it work?](howdoesitwork.jpg)

## EventMachine, How Does It Work? ##

!SLIDE

# C++ #

!SLIDE

# [Event loop](http://en.wikipedia.org/wiki/Event_loop) #

!SLIDE

# [Reactor pattern](http://en.wikipedia.org/wiki/Reactor_pattern) #

!SLIDE

## Single-threaded ##

!SLIDE bullets incremental

## Runs Callbacks on Events ##

* Connection established
* Data received
* Connection closed
* Timer fired

!SLIDE

## This... ##

    @@@ruby
    response = get_some_data(request)

!SLIDE

## ...turns into this ##

    @@@ ruby
    get_some_data do |request|
      send_response
    end
    
!SLIDE

## Mmmmmmh, callbacks ##

!SLIDE bullets incremental

## Evented I/O for ##

* Sockets
* External processes
* Keyboard
* File Watchers

!SLIDE

## Multiple I/O Ops ##

!SLIDE

## One Processing Operation ##

!SLIDE

## Make it fast ##

!SLIDE

## The Loop ##

    EM.run do
      ...
    end

!SLIDE bullets incremental

## Threads are supported ##

* I/O always on the Reactor Thread!
