require 'eventmachine'
EM.run do
    EM.start_server '127.0.0.1', 8081 do |conn|
      def conn.receive_data(data)
        send_data(data)
      end
    end
end
