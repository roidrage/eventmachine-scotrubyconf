!SLIDE center

![How does it work?](howdoesitwork.jpg)

## EventMachine, How Does It Work? ##

!SLIDE

# C++ #

!SLIDE

# [Reactor pattern](http://en.wikipedia.org/wiki/Reactor_pattern) #

!SLIDE

# [Event loop](http://en.wikipedia.org/wiki/Event_loop) #

!SLIDE

## Single-threaded ##

!SLIDE

## Reactor multiplexes I/O Ops #

!SLIDE bullets incremental

## Runs Callbacks on Events ##

* Connection established
* Data received
* Connection closed
* Timer fired

!SLIDE bullets incremental

## Evented I/O for ##

* Files
* Sockets
* External processes
* Keyboard

!SLIDE

## Multiple I/O Ops ##

!SLIDE

## One processing operation ##

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
