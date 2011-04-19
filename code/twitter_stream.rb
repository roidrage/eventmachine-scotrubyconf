require 'rubygems'
require 'em-http'
require 'json'

EM.run {
  username = ''
  password = ''
  term = 'bieber'
  buffer = ""

  http = EventMachine::HttpRequest.new('http://stream.twitter.com/1/statuses/filter.json').post({
    :head => { 'Authorization' => [ username, password ] },
    :query => { "track" => term }
  })

  http.callback {
    unless http.response_header.status == 200
      puts "Call failed with response code #{http.response_header.status}"
    end
  }

  http.stream do |chunk|
    buffer += chunk
    while line = buffer.slice!(/.+\r\n/)
      tweet = JSON.parse(line)
      puts tweet['text']
    end
  end
}
