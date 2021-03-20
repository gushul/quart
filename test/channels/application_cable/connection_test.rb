require 'test_helper'

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  def hex
    'some_hex'
  end

  def test_connection
    SecureRandom.stub :hex, hex do
      connect

      assert_equal hex, connection.id
    end
  end

  def test_disconnect
    connect

    assert_changes :connection, from: connection, to: nil do
      disconnect
    end
  end
end
