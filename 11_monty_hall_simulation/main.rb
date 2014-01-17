require 'test/unit'

class Game
  attr_accessor :doors

  def initialize
    @doors = []
  end

  def start(door_count = 3)
    self.doors = Array.new(door_count) { Door.new(:donkey) }
    self.doors.sample.contents = :car
  end
end

class Door
  attr_accessor :state, :contents

  def initialize(contents = nil)
    @contents = contents
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

  def car?
    self.contents == :car
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

  def test_doors_that_hold_cars_know_it
    @door.contents = :car
    assert @door.car?
  end
end

class GameTest < Test::Unit::TestCase
  def setup
    @game = Game.new
  end

  def test_started_game_has_three_doors_by_default
    @game.start
    assert_equal 3, @game.doors.length
  end

  def test_games_only_have_one_door_with_a_car
    @game.start
    doors_with_cars = @game.doors.keep_if(&:car?)
    assert_equal 1, doors_with_cars.length
  end
end
