require 'test/unit'

class Door
  attr_accessor :state, :contents

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

  def donkey?
    self.contents == :donkey
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

  def test_doors_that_hold_donkeys_know_it
    @door.contents = :donkey
    assert @door.donkey?
  end
end
