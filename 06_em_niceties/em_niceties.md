!SLIDE

## Important EventMachine Sugar ##

!SLIDE small

## One-Shot Timers ##

    @@@ruby
    EM.add_timer(1) do
      # run in one second
    end

!SLIDE small

## Periodic Timers ##

    @@@ruby
    EM.add_periodic_timer(1) do
      # run every second
    end

!SLIDE

## Schedule for Next Loop ##

## `EM.next_tick` ##

!SLIDE

## Split up Iteration ##

    @@@ruby
    i = 0
    block = proc do
      if i < 100
        i += 1
        EM.next_tick &block
      end
    end
    EM.next_tick &block

!SLIDE

## Use the threadpool, Luke! ##

## `EM.defer` ##

!SLIDE

## This blocks the reactor ##

    @@@ruby
    sleep 5

!SLIDE small

## Split up Blocking Code ##

    @@@ruby
    EM.add_periodic_timer(1) do
      puts "ping"
    end

    EM.defer do
      puts "sleep"
      sleep 5
      puts "done"
    end

!SLIDE small

# Ping Pong #

    @@@ruby
    EM.next_tick do
    end

!SLIDE small

# Ping Pong #

    @@@ruby
    EM.next_tick do
      EM.defer do
        puts "THREAD, I AM IN U!"
      end
    end

!SLIDE small

# Ping Pong #

    @@@ruby
    EM.next_tick do
      EM.defer do
        puts "THREAD, I AM IN U!"
        EM.next_tick do
          puts "REACTOR THREAD, I AM IN U!"
        end
      end
    end

!SLIDE small

# Queues #

    @@@ruby
    queue = EM::Queue.new

    queue.pop do |msg|
      puts "Popped: #{msg}""
    end

    queue.push("ZOMG, MESSAGE!!")

!SLIDE

# Queues #

## Pop just once ##

!SLIDE small

# Queues #

    @@@ruby
    queue = EM::Queue.new
    popper = lambda do 
      puts "Popped #{msg}"
      queue.pop &popper
    end

    queue.pop &popper

    EM.add_periodic_timer(1) do
      queue.push("ZOMG, MESSAGE!!")
    end

!SLIDE

## `EM.epoll` ##

!SLIDE

## `EM.kqueue` ##
