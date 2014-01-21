require 'test/unit'

class LanguageDetector
  attr_accessor :dictionaries

  def dictionaries_containing_word(word)
    downcase_dictionaries!

    self.dictionaries.map do |language, dictionary|
      language if dictionary.include? word.downcase
    end.compact
  end

  def downcase_dictionaries!
    self.dictionaries.each { |_, dictionary| dictionary.map(&:downcase!) }
  end

  def detect_language(phrase)
    phrase.split.map do |word|
      dictionaries = dictionaries_containing_word(word)
      return [] if dictionaries.empty?
    end
  end
end

class LanguageDetectorTest < Test::Unit::TestCase
  def setup
    @detector = LanguageDetector.new
    @detector.dictionaries = {
      'English'  => ['Jonan', 'Becky', 'Kaja'],
      'Japanese' => ['Jonan', 'Becky', 'Tavin'],
      'German'   => ['Becky', 'Kaja', 'Tavin']
    }
  end

  def test_dictionaries_containing_word_returns_the_titles_of_all_lists_containing_a_word
    result = @detector.dictionaries_containing_word('Jonan')
    assert_equal ['English', 'Japanese'], result
  end

  def test_downcase_dictionaries!
    @detector.downcase_dictionaries!
    assert_equal ['jonan', 'becky', 'kaja'], @detector.dictionaries['English']
  end

  def test_dictionaries_containing_word_ignores_case
    result = @detector.dictionaries_containing_word('KaJa')
    assert_equal ['English', 'German'], result
  end

  def test_detect_language_returns_empty_array_if_language_cannot_be_identified
    assert_equal [], @detector.detect_language('all mimsy were the borogroves')
  end
end
