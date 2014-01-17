require 'test/unit'

class Door
  attr_accessor :state

  def initialize
    @state = :closed
  end

  def closed?
    self.state == :closed
  end

  def open
    self.state = :open
  end

  def open?
    self.state == :open
  end
end

class DoorTest < Test::Unit::TestCase
  def setup
    @door = Door.new
  end

  def test_door_starts_closed
    assert @door.closed?
  end

  def test_door_can_be_opened
    @door.open
    assert @door.open?
  end
end
