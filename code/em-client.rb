require 'eventmachine'

module EchoClient
  def post_init
    send_data "hello world"
  end

  def receive_data(data)
    puts "Received #{data}"
  end
end
EM.run do
  EM.connect '127.0.0.1', 8081, EchoClient
end
