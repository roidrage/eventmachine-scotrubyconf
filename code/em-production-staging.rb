    require 'em-proxy'

EM.run do
  Proxy.start(:host => "0.0.0.0", :port => 8080) do |conn|
    conn.server :production, :host => '127.0.0.1', :port => 80
    conn.server :staging, :host => 'www.google.com', :port => 80

    conn.on_data do |data|
      data
    end

    conn.on_response do |server, resp|
      resp if server == :production
    end
  end
end
