require 'eventmachine'

EM.run do
  EM.open_datagram_socket '127.0.0.1', 5300 do |conn|
    def conn.receive_data(data)
      puts "Received #{data}"
    end
  end

  EM.start_server '127.0.0.1', 5300 do |conn|
    def conn.receive_data(data)
      puts "Received TCP data #{data}"
    end
  end
end
