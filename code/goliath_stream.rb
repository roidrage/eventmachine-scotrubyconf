require 'goliath'

class GoliathStream < Goliath::API
  def on_close(env)
    env.logger.info "Connection closed."
  end

  def response(env)
    i = 0
    pt = EM.add_periodic_timer(1) do
      env.stream_send("#{i} ")
      i += 1
    end

    EM.add_timer(10) do
      pt.cancel

      env.stream_send("!! BOOM !!\n")
      env.stream_close
    end

    [200, {}, Goliath::Response::STREAMING]
  end
end

