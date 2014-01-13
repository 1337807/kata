require 'test/unit'

class Transposer
  attr_accessor :word_grid

  def initialize
    @word_grid = []
  end

  def insert(word)
    word.split(//).each do |letter|
      self.word_grid << [letter]
    end
  end
end

class TransposerTest < Test::Unit::TestCase
  def setup
    @transposer = Transposer.new
  end

  def test_transposer_increases_the_word_grid_height_to_match_new_word_length
    word = 'Jonan'
    @transposer.insert word
    assert_equal word.length, @transposer.word_grid.length
  end
end
