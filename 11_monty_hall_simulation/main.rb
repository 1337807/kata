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
  attr_accessor :game_count, :one_pick_results, :two_pick_results

  def initialize(game_count = 10)
    @one_pick_results = []
    @two_pick_results = []
    @game_count = game_count
  end

  def run
  end

  def gather_one_pick_results
    self.game_count.times do
      game = Game.new.start
      chosen_door = game.random_closed_door
      self.one_pick_results << chosen_door.car?
    end
  end

  def gather_two_pick_results
    self.game_count.times do
      game = Game.new.start
      chosen_door = game.random_closed_door
      self.two_pick_results << chosen_door.car?
    end
  end

  def one_pick_percentage_correct
    100 * (self.one_pick_results.count(true) / self.one_pick_results.length.to_f)
  end

  def two_pick_percentage_correct
  end
end

class SimulationTest < Test::Unit::TestCase
  def setup
    @simulation = Simulation.new
  end

  def test_collect_one_pick_results_collects_the_default_number_of_game_results
    @simulation.gather_one_pick_results
    assert_equal 10, @simulation.one_pick_results.length
  end

  def test_collect_two_pick_results_collects_the_default_number_of_game_results
    @simulation.gather_two_pick_results
    assert_equal 10, @simulation.two_pick_results.length
  end

  def test_running_collects_both_sets_of_game_results
    @simulation.gather_one_pick_results
    @simulation.gather_two_pick_results
    assert_equal 20, (@simulation.one_pick_results + @simulation.two_pick_results).length
  end

  def test_one_pick_percentage_correct_returns_the_correct_ratio
    @simulation.one_pick_results = [true, false]
    assert_equal 50, @simulation.one_pick_percentage_correct
  end
end
