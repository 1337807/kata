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
