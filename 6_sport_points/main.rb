require 'test/unit'

class ScoreValidator
  attr_accessor :point_types

  def score_is_divisible_by_number_in_set?(score, set)
    set.each do |number|
      return true if score % number == 0
    end

    false
  end

  def score_is_valid?(score)
    return true if score_is_divisible_by_number_in_set?(score, point_types.keys)

    point_types.keys.each do |point_type|
      return true if score_is_valid?(score - point_type)
    end
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

  def test_score_is_valid_returns_true_for_touchdown
    @validator.point_types = { 6 => 'touchdown' }
    result = @validator.score_is_valid?(6)
    assert result
  end

  def test_score_is_valid_returns_true_for_extra_point
    @validator.point_types = { 3 => 'field goal' }
    result = @validator.score_is_valid?(3)
    assert result
  end

  def test_score_is_valid_returns_true_for_touchdown_with_point_and_field_goal
    @validator.point_types = { 3 => 'field goal', 7 => 'touchdown' }
    result = @validator.score_is_valid?(10)
    assert result
  end

  def test_score_is_valid_returns_true_for_two_touchdowns_with_points_and_field_goal
    @validator.point_types = { 3 => 'field goal', 7 => 'touchdown' }
    result = @validator.score_is_valid?(17)
    assert result
  end
end
