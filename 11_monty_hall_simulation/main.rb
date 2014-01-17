require 'test/unit'

class Door
  attr_accessor :open

  def initialize
    @open = false
  end

  def closed?
    !self.open
  end
end

class DoorTest < Test::Unit::TestCase
  def setup
    @door = Door.new
  end

  def test_door_starts_closed
    assert @door.closed?
  end
end
