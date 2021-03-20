class ChatChannel < ApplicationCable::Channel
  attr_accessor :updated_at

  MAX_SECONDS_TIMEOUT = 5

  periodically :notify_connection_count, every: 1.seconds

  periodically :checking_connect, every: 1.seconds

  def subscribed
    set_updated_at

    # ActionCable::Connection::WebSocket
    websocket = connection.instance_variable_get(:@websocket)

    # ActionCable::Connection::ClientSocket
    client_socket = websocket.instance_variable_get(:@websocket)

    # WebSocket::Driver::Hybi
    @driver = client_socket.instance_variable_get(:@driver)

    @driver&.on(:pong)  { set_updated_at }
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify_connection_count
    transmit({ 'title': 'count', 'message': connection.server.connections.size })
  end

  def checking_connect
    @driver&.ping

    time_ago = Time.now - updated_at

    if time_ago  >= MAX_SECONDS_TIMEOUT
      ActionCable.server.remove_connection(connection)
    end
  end

  private

  def set_updated_at
    @updated_at = Time.now
  end
end
