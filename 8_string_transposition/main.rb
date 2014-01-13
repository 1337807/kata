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
        self.word_grid << []

        (self.word_grid[0].length - 1).times do
          self.word_grid[index] << ' '
        end

        self.word_grid[index] << letter
      end
    end
  end
end

class TransposerTest < Test::Unit::TestCase
  def setup
    @transposer = Transposer.new
  end

  def test_inserting_increases_the_word_grid_height_to_match_new_word_length
    word = 'Jonan'
    @transposer.insert word
    assert_equal word.length, @transposer.word_grid.length
  end

  def test_inserting_expands_word_grid_to_the_length_of_the_longest_word
    short_word = 'Jonan'
    long_word = 'Scheffler'
    @transposer.insert short_word
    @transposer.insert long_word
    assert_equal long_word.length, @transposer.word_grid.length
  end

  def test_inserting_a_longer_word_adds_padding_to_shorter_words
    short_word = 'Jonan'
    long_word = 'Scheffler'
    @transposer.insert short_word
    @transposer.insert long_word
    result = @transposer.word_grid[5..8].map { |row| row[0] }.join
    assert_equal '    ', result
  end
end
