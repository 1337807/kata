require 'test/unit'

class Sandscape
  BLOCK_TYPES = {
    '.' => 'sand',
    '#' => 'stone',
    ' ' => 'empty'
  }

  def is_sand?(block)
    block == '.'
  end

  def block_type(block)
    BLOCK_TYPES[block]
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
end
