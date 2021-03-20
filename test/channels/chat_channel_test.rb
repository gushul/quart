require 'test_helper'

class ChatChannelTest < ActionCable::Channel::TestCase
  def test_subscribed
    subscribe

    assert subscription.confirmed?
  end

  def test_checking_connect_with_more_than_5_second
    time = Time.now - 5.second
    ChatChannel.any_instance.stubs(:updated_at).returns(time)

    subscribe

    ActionCable.server.expects(:remove_connection).with(connection).at_least_once

    self.perform(:checking_connect)
  end

  def test_checking_connect_with_less_than_5_second
    time = Time.now - 4.second
    ChatChannel.any_instance.stubs(:updated_at).returns(time)

    subscribe

    ActionCable.server.expects(:remove_connection).with(connection).never

    self.perform(:checking_connect)
  end
end
