require 'test/unit'

class ScoreValidator
  def score_is_divisible_by_number_in_set?(score, set)
    set.each do |number|
      return true if score % number == 0
    end

    false
  end
end

class ScoreValidatorTest < Test::Unit::TestCase
  def setup
    @validator = ScoreValidator.new
  end

  def test_score_is_divisible_by_number_in_set?
    [4, 5, 9, 18].each do |score|
      set = [2, 5, 9]
      result = @validator.score_is_divisible_by_number_in_set?(score, set)
      assert result
    end
  end

  def test_score_is_divisible_by_number_in_set_returns_false_for_invalid_score
    [3, 7, 11, 17].each do |score|
      set = [2, 5, 9]
      result = @validator.score_is_divisible_by_number_in_set?(score, set)
      refute result
    end
  end
end
