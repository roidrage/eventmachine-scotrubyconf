require 'eventmachine'
require 'evma_httpserver'

EM.kqueue
class FileServer < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    filename = File.basename(@http_request_uri)
    response = EventMachine::DelegatedHttpResponse.new(self)
    response.status = 200
    response.content_type "text/plain"
    response.send_headers
  end
end

EM.run do
  EM.start_server '127.0.0.1', 8080, FileServer
end
