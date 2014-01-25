require 'test/unit'

class Reaction
  attr_accessor :size, :grid

  def initialize
    @size = 1
    resize_grid
  end

  def size=(new_size)
    @size = new_size
    resize_grid
  end

  def resize_grid
    self.grid = Array.new(self.size) { Array.new(self.size) }
  end
end

class ReactionTest < Test::Unit::TestCase
  def setup
    @reaction = Reaction.new
  end

  def test_grid_has_width_and_height_equal_to_reaction_size
    @reaction.size = 5
    expected = [
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil]
    ]
    assert_equal expected, @reaction.grid
  end
end

class Cell
  attr_accessor :name, :state, :vectors
  PROPAGATED_OUTPUT = 'X'

  def initialize
    @vectors = []
  end

  def out
    if propagated?
      PROPAGATED_OUTPUT
    else
      self.name
    end
  end

  def propagated?
    self.state == :propagated
  end

  def propagate!
    self.state = :propagated
  end

  def parse_vectors(direction_abbreviations, magnitude)
    direction_abbreviations.split(//).each do |direction_abbreviation|
      self.vectors << Vector.new(direction_abbreviation, magnitude)
    end
  end
end

class CellTest < Test::Unit::TestCase
  def setup
    @cell = Cell.new
  end

  def test_out_returns_the_cells_name
    @cell.name = 'A'
    assert_equal 'A', @cell.out
  end

  def test_out_returns_x_if_the_cell_has_propagated
    @cell.name = 'A'
    @cell.propagate!
    assert_equal 'X', @cell.out
  end

  def test_parse_vectors_creates_new_vectors_with_the_given_directions_and_magnitude
    @cell.parse_vectors('ud', 5)
    result = @cell.vectors.map { |vector| [vector.direction, vector.magnitude] }
    assert_equal [[:up, 5], [:down, 5]], result
  end
end

class Vector
  attr_accessor :direction, :magnitude
  DIRECTION_ABBREVIATIONS = {
    'u' => :up,
    'd' => :down,
    'r' => :right,
    'l' => :left
  }

  def initialize(direction = nil, magnitude = nil)
    self.direction = direction if direction
    self.magnitude = magnitude if magnitude
  end

  def direction=(new_direction)
    if full_name = DIRECTION_ABBREVIATIONS[new_direction.downcase]
      @direction = full_name
    else
      @direction = new_direction
    end
  end
end

class VectorTest < Test::Unit::TestCase
  def setup
    @vector = Vector.new
  end

  def test_direction_can_be_set_with_a_single_character
    @vector.direction = 'u'
    assert_equal :up, @vector.direction
  end

  def test_direction_abbreviations_are_not_case_sensitive
    @vector.direction = 'D'
    assert_equal :down, @vector.direction
  end
end
