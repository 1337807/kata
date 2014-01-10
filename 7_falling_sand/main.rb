require 'test/unit'

class Sandscape
  attr_accessor :grid

  BLOCK_TYPES = {
    '.' => 'sand',
    '#' => 'stone',
    ' ' => 'empty'
  }

  def initialize
    @grid = [[]]
  end

  def is_sand?(block)
    block == '.'
  end

  def block_type(block)
    BLOCK_TYPES[block]
  end

  def random_block
    BLOCK_TYPES.keys.sample
  end

  def generate(size)
    self.grid = Array.new(size) do
      Array.new(size) { random_block }
    end
  end

  def get_block(x, y)
    self.grid[y][x]
  end

  def drop_block(x, y)
    return false unless self.grid[y + 1]

    block_below = get_block(x, y + 1)

    if block_type(block_below) == 'empty'
      block = get_block(x, y)
      set_block(' ', x, y)
      set_block(block, x, y + 1)

      true
    else
      false
    end
  end

  def set_block(block, x, y)
    self.grid[y][x] = block
  end

  def drop_sand
    (self.grid.length - 1).times do
      self.grid.each_with_index do |row, y|
        row.each_with_index do |block, x|
          drop_block(x, y) if is_sand?(block)
        end
      end
    end
  end
end

class SandscapeTest < Test::Unit::TestCase
  def setup
    @sandscape = Sandscape.new
  end

  def test_is_sand_returns_true_for_dot
    assert @sandscape.is_sand? '.'
  end

  def test_is_sand_returns_false_for_empty
    refute @sandscape.is_sand? ' '
  end

  def test_block_type
    assert_equal 'stone', @sandscape.block_type('#')
  end

  def test_random_block
    assert Sandscape::BLOCK_TYPES.keys.include? @sandscape.random_block
  end

  def test_generate_builds_grids_to_given_dimensions
    @sandscape.generate(5)
    assert_equal [5, 5], [@sandscape.grid.length, @sandscape.grid.first.length]
  end

  def test_get_block_returns_the_block_at_the_given_dimensions
    @sandscape.grid = [['#']]
    assert_equal '#', @sandscape.get_block(0, 0)
  end

  def test_set_block
    @sandscape.set_block('^', 0, 0)
    assert_equal [['^']], @sandscape.grid
  end

  def test_drop_block_moves_the_block_down_one_row
    @sandscape.grid = [ ['%', ' '],
                        [' ', ' '] ]
    expected =        [ [' ', ' '],
                        ['%', ' '] ]
    @sandscape.drop_block(0, 0)

    assert_equal expected, @sandscape.grid
  end

  def test_drop_block_does_not_drop_blocks_to_occupied_positions
    @sandscape.grid = [ ['%', ' '],
                        ['#', ' '] ]
    expected =        [ ['%', ' '],
                        ['#', ' '] ]
    @sandscape.drop_block(0, 0)

    assert_equal expected, @sandscape.grid
  end

  def test_drop_sand_moves_all_sand_down_until_it_hits_stone
    @sandscape.grid = [ ['.', '#', '.', ' ', '.'],
                        [' ', '.', '.', '.', ' '],
                        [' ', ' ', ' ', ' ', '.'],
                        [' ', ' ', ' ', ' ', ' '],
                        ['.', '#', ' ', '#', '#'] ]
    expected =        [ [' ', '#', ' ', ' ', ' '],
                        [' ', ' ', ' ', ' ', ' '],
                        [' ', ' ', ' ', ' ', '.'],
                        ['.', '.', '.', '.', '.'],
                        ['.', '#', '.', '#', '#'] ]
    @sandscape.drop_sand

    assert_equal expected, @sandscape.grid
  end
end
