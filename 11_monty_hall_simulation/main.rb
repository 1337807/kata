require 'test/unit'

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

class Game
  attr_accessor :doors

  def initialize
    @doors = []
  end

  def start(door_count = 3)
    self.doors = Array.new(door_count) { Door.new(:donkey) }
    self.doors.sample.contents = :car
    self
  end

  def random_closed_door
    closed_door = self.doors.keep_if { |door| door.closed? }.sample
    self.doors.delete(closed_door)
  end

  def random_donkey_door
    donkey_door = self.doors.keep_if { |door| door.donkey? }.sample
    self.doors.delete(donkey_door)
  end
end

class GameTest < Test::Unit::TestCase
  def setup
    @game = Game.new
    @game.start
  end

  def test_started_game_has_three_doors_by_default
    assert_equal 3, @game.doors.length
  end

  def test_games_only_have_one_door_with_a_car
    doors_with_cars = @game.doors.keep_if(&:car?)
    assert_equal 1, doors_with_cars.length
  end

  def test_random_closed_door_selects_only_closed_doors
    assert @game.random_closed_door.closed?
  end

  def test_random_closed_door_decreases_the_available_door_count_by_one
    @game.random_closed_door
    assert_equal 2, @game.doors.length
  end

  def test_open_random_donkey_door_only_opens_goat_doors
    assert @game.random_donkey_door.donkey?
  end
end

class Simulation
  attr_accessor :game_count, :one_pick_results

  def initialize(game_count = 10)
    @one_pick_results = []
    @game_count = game_count
  end

  def run
    self.game_count.times do
      game = Game.new.start
      chosen_door = game.random_closed_door
      self.one_pick_results << chosen_door.car?
    end
  end
end

class SimulationTest < Test::Unit::TestCase
  def setup
    @simulation = Simulation.new
  end

  def test_simulations_collect_one_pick_results_for_the_default_number_of_games
    @simulation.run
    assert = @simulation.one_pick_results.length == 10
  end
end
