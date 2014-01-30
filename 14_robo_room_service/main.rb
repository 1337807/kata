require 'test/unit'

class Map
  attr_accessor :grid

  def parse_grid(input_grid)
    self.grid = input_grid.split("\n").map do |row|
      row.split(//)
    end
  end
end

class MapTest < Test::Unit::TestCase
  def setup
    @map = Map.new
  end

  def test_parse_grid
    input = "ABCDE\nFGHIJ\nKLMNO\nPQRST\nUVWXY"
    result = @map.parse_grid input

    expected = [
      ['A', 'B', 'C', 'D', 'E'],
      ['F', 'G', 'H', 'I', 'J'],
      ['K', 'L', 'M', 'N', 'O'],
      ['P', 'Q', 'R', 'S', 'T'],
      ['U', 'V', 'W', 'X', 'Y']
    ]
    assert_equal expected, result
  end
end
