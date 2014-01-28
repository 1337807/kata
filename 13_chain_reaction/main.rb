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

  def get_cell(x, y)
    self.grid[y][x]
  end

  def set_cell(x, y, cell)
    self.grid[y][x] = cell
  end

  def resize_grid
    self.grid = Array.new(self.size) { Array.new(self.size) }
  end

  def parse_cell(coordinates_with_vectors)
    x, y, magnitude, directions = coordinates_with_vectors.split
    x, y, magnitude = x.to_i, y.to_i, magnitude.to_i
    set_cell(x, y, Cell.new(directions, magnitude))
  end

  def propagate_cell(x, y)
    cell = grid[y][x]
    cell.propagate!

    cell.vectors.each do |vector|
      propagate_cells_along_vector(x, y, vector)
    end
  end

  def propagate_along_x_axis(options)
    x, y = options[:x], options[:y]
    operation, magnitude = options[:operation], options[:magnitude]

    magnitude.times do |distance_from_origin|
      changed = x.send(operation, distance_from_origin)
      cell = get_cell(x, changed)
      next if changed < 0 || cell.nil?
      propagate_cell(x, changed) unless cell.propagated?
    end
  end

  def propagate_along_y_axis(options)
    x, y = options[:x], options[:y]
    operation, magnitude = options[:operation], options[:magnitude]

    magnitude.times do |distance_from_origin|
      changed = x.send(operation, distance_from_origin)
      cell = get_cell(changed, y)
      next if changed < 0 || cell.nil?
      propagate_cell(changed, y) unless cell.propagated?
    end
  end

  def propagate_cells_along_vector(x, y, vector)
    direction, magnitude = vector.direction, vector.magnitude

    options = Hash(:x => x, :y => y)
    options[:direction], options[:magnitude] = vector.direction, vector.magnitude

    if direction == :up
      options[:operation] = :-
      propagate_along_y_axis(options)
    elsif direction == :down
      options[:operation] = :+
      propagate_along_y_axis(options)
    elsif direction == :left
      options[:operation] = :-
      propagate_along_y_axis(options)
    elsif direction == :right
      options[:operation] = :+
      propagate_along_y_axis(options)
    end
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

  def test_parse_cell_adds_a_cell_with_the_correct_vectors_to_the_grid
    @reaction.size = 10
    @reaction.parse_cell('3 7 5 lr')
    cell = @reaction.grid[7][3]
    result = cell.vectors.map { |vector| [vector.direction, vector.magnitude] }
    assert_equal [[:left, 5], [:right, 5]], result
  end

  def test_propagate_cell_calls_propagate_on_all_cells_in_vector_paths
    @reaction.size = 10
    @reaction.parse_cell('5 5 5 udlr')
    test_cell_propagated = false
    test_cell = Cell.new
    test_cell.singleton_class.send(:define_method,
                                   :propagate!,
                                   -> { test_cell_propagated = true })
    @reaction.grid[5][6] = test_cell

    @reaction.propagate_cell(5, 5)
    assert test_cell_propagated
  end
end

class Cell
  attr_accessor :name, :state, :vectors
  PROPAGATED_OUTPUT = 'X'

  def initialize(directions = nil, magnitude = nil)
    @vectors = []
    if directions && magnitude
      parse_vectors(directions, magnitude)
    end
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
