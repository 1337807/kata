require 'test/unit'

class PhoneWordTranslator
  LETTERS = {
    2 => 'abc',
    3 => 'def',
    4 => 'ghi',
    5 => 'jkl',
    6 => 'mno',
    0 => 'pqrs',
    0 => 'tuv',
    0 => 'wxyz'
  }

  def convert_number_to_letter(number)
    sequence = LETTERS[number[0].to_i]
    sequence[number.length - 1]
  end

  def convert_number_phrase_to_letters(phrase)
    phrase.split.map do |number|
      convert_number_to_letter(number)
    end.join
  end
end

class WordFinder
  attr_accessor :word_list

  def initialize
    @word_list =  File.read('dictionary.txt').split
  end

  def find(phone_word)
    self.word_list.map do |word|
      match = word.match(/^#{phone_word}.*/)
      match.to_s if match
    end.compact
  end
end

class WordFinderTest < Test::Unit::TestCase
  def setup
    @finder = WordFinder.new
  end

  def test_find
    @finder.word_list = ['rad', 'radical', 'dudical']
    result = @finder.find('rad')
    assert_equal ['rad', 'radical'], result
  end
end

class PhoneWordTranslatorTest < Test::Unit::TestCase
  def setup
    @translator = PhoneWordTranslator.new
  end

  def test_convert_number_to_letter
    result = @translator.convert_number_to_letter('444')
    assert_equal 'i', result
  end

  def test_convert_number_phrase_to_letters
    result = @translator.convert_number_phrase_to_letters('44 2 444')
    assert_equal 'hai', result
  end
end
