require 'test/unit'

class Transposer
  attr_accessor :word_grid

  def initialize
    @word_grid = []
  end

  def insert(word)
    word.split(//).each_with_index do |letter, index|
      if self.word_grid[index]
        self.word_grid[index] << letter
      else
        self.word_grid << [letter]
      end
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

  def test_transposer_expands_to_the_length_of_the_longest_word
    short_word = 'Jonan'
    long_word = 'Scheffler'
    @transposer.insert short_word
    @transposer.insert long_word
    assert_equal long_word.length, @transposer.word_grid.length
  end
end
