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
end

class PhoneWordTranslatorTest < Test::Unit::TestCase
  def setup
    @translator = PhoneWordTranslator.new
  end

  def test_convert_number_to_letter
    result = @translator.convert_number_to_letter('444')
    assert_equal 'i', result
  end
end
