require 'test/unit'

class Sandscape
  def is_sand?(block)
    block == '.'
  end
end

class SandscapeTest < Test::Unit::TestCase
  def setup
    @sandscape = Sandscape.new
  end

  def test_is_sand_returns_true_for_dot
    result = @sandscape.is_sand? '.'
    assert result
  end
end
