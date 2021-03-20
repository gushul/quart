module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :id

    def connect
      self.id = SecureRandom.hex
    end

    # TODO try on prod
    # TODO: rewrite
    def disconnect
      ActionCable.server.broadcast("action_cable/#{id}", { type: 'disconnect' })
      ActionCable.server.broadcast("chat_channel_#{id}", { type: 'disconnect' })
    end
  end
end
