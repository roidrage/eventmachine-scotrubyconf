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
