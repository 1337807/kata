require 'test/unit'

class BrailleTranslator
  ENGLISH = {
    'a'=>'O.....', 'b'=>'O.O...', 'c'=>'OO....', 'd'=>'OO.O..', 'e'=>'O..O..',
    'f'=>'OOO...', 'g'=>'OOOO..', 'h'=>'O.OO..', 'i'=>'.OO...', 'j'=>'.OOO..',
    'k'=>'O...O.', 'l'=>'O.O.O.', 'm'=>'OO..O.', 'n'=>'OO.OO.', 'o'=>'O..OO.',
    'p'=>'OOO.O.', 'q'=>'OOOOO.', 'r'=>'O.OOO.', 's'=>'.OO.O.', 't'=>'.OOOO.',
    'u'=>'O...OO', 'v'=>'O.O.OO', 'w'=>'.OOO.O', 'x'=>'OO..OO', 'y'=>'OO.OOO',
    'z'=>'O..OOO'
  }

  def translate_from_english_character(english)
    ENGLISH[english]
  end

  def translate_from_braille_character(braille)
    ENGLISH.invert[braille]
  end
end

class BrailleTranslatorTest < Test::Unit::TestCase
  def setup
    @translator = BrailleTranslator.new
  end

  def test_translate_from_braille_character
    result = @translator.translate_from_braille_character('.OOO..')
    assert_equal 'j', result
  end

  def test_translate_from_english_character
    result = @translator.translate_from_english_character('o')
    assert_equal 'O..OO.', result
  end
end
