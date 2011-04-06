!SLIDE

# Important EventMachine Sugar #

!SLIDE

## Use the threadpool, Luke! ##

## `EM.defer` ##

!SLIDE

## Run code on next iteration ##

## `EM.next_tick` ##

!SLIDE smaller

# Ping pong #

    @@@ruby
    EM.next_tick do
      EM.defer do
        puts "THREAD, I AM IN U!"
        EM.next_tick do
          puts "REACTOR THREAD I AM IN U!"
        end
      end
    end
