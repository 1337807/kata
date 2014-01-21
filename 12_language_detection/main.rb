require 'test/unit'

class LanguageDetector
  attr_accessor :dictionaries

  def dictionaries_containing_word(word)
    self.dictionaries.map do |language, dictionary|
      language if dictionary.include? word
    end.compact
  end

  def downcase_dictionaries!
    self.dictionaries.each { |_, dictionary| dictionary.map(&:downcase!) }
  end
end

class LanguageDetectorTest < Test::Unit::TestCase
  def setup
    @detector = LanguageDetector.new
    @detector.dictionaries = {
      'English'  => ['Jonan', 'Becky', 'Kaja'],
      'Japanese' => ['Jonan', 'Becky', 'Tavin'],
      'German'   => ['Becky', 'Kaja', 'Tavin'],
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
end
