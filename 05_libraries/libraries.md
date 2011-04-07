!SLIDE
 
# Usages #

!SLIDE

# [Proxymachine](https://github.com/mojombo/proxymachine) #

## Content-Aware TCP-Routing ##

!SLIDE small

    @@@ruby
    proxy do
      {:remote => "google.com:80"}
    end

!SLIDE

    proxymachine -c proxy.rb

!SLIDE

# [em-proxy](https://github.com/igrigorik/em-proxy) #

!SLIDE even-smaller

    @@@ruby
    require 'em-proxy'

    Proxy.start(:host => "0.0.0.0", :port => 80) do |conn|
      conn.server :production, :host => '127.0.0.1', :port => 8080
      conn.server :staging, :host => 'www.google.com', :port => 80

      conn.on_data do |data|
        data
      end
 
      conn.on_response do |server, resp|
        resp if server == :production
      end
    end

!SLIDE bullets incremental

# [Goliath](https://github.com/postrank-labs/goliath) #

* Evented Web Framework
* Rack API
* Fibers

!SLIDE smaller

    @@@ruby
    require 'goliath'

    class HelloWorld < Goliath::API
      def response(env)
        [200, {}, "hello world"]
      end
    end

!SLIDE

# Fiber Power!! #

!SLIDE small

    @@@ruby
    class Srv < Goliath::API
      use Goliath::Rack::Params
      use Goliath::Rack::DefaultMimeType
      use Goliath::Rack::Formatters::JSON
      use Goliath::Rack::Render

      def response(env)
        User.find_by_sql("SELECT SLEEP(10)")
        [200, {}, User.find(params['id'])]
      end
    end

!SLIDE

# [Tramp](https://github.com/lifo/tramp) #

## Evented ORM ##

!SLIDE smaller

    @@@ruby
    class User < Tramp::Base
      attribute :id, :type => Integer, :primary_key => true
      attribute :name

      validates_presence_of :name
    end

!SLIDE small

    @@@ruby
    user = User.new
    user.save do |status|
      if not status.success?
        puts "Here be errors"
      end
    end

!SLIDE

## Rails on EventMachine ##

!SLIDE small

# This... #

    @@@ruby
    class WidgetsController < ApplicationController
      def index
        Widget.find_by_sql("select sleep(1)")
        render :text => "Oh hai"
      end
    end

!SLIDE small

# ...turns into this #

    @@@ruby
    class WidgetsController < ApplicationController
      def index
        Widget.find_by_sql("select sleep(1)")
        render :text => "Oh hai"
      end
    end

!SLIDE bullets

* [Rails 2.3](http://www.mikeperham.com/2010/04/03/introducing-phat-an-asynchronous-rails-app/) and [Rails 3.0](https://gist.github.com/432563)
* Ruby 1.9 and Fibers, duh!
