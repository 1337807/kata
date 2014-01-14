require 'test/unit'

class Lock
  attr_accessor :size, :digits, :clicks

  def initialize(size = 10)
    @size = size
    @digits = []
    @clicks = 0
  end

  def enter_digit(digit)
    if self.digits.empty?
      self.clicks += first_digit_clicks(digit)
    elsif self.digits.length == 1
      self.clicks += second_digit_clicks(digit)
    elsif self.digits.length == 2
      self.clicks += third_digit_clicks(digit)
    end

    self.digits << digit
  end

  def first_digit_clicks(digit)
    self.size * 2 + digit
  end

  def second_digit_clicks(digit)
    self.size + self.digits.first + self.size - digit
  end

  def third_digit_clicks(digit)
    (self.digits[1] - digit).abs
  end
end

class LockTest < Test::Unit::TestCase
  def setup
    @lock = Lock.new
  end

  def test_first_digit_increases_clicks_by_twice_size_plus_digit
    @lock.size = 7
    digit = 5
    expected_increase = 2 * @lock.size + digit
    @lock.enter_digit(digit)
    assert_equal expected_increase, @lock.clicks
  end

  def test_second_digit_increases_clicks_by_size_and_first_digit_and_size_less_second_digit
    @lock.size = 12
    @lock.enter_digit(5)
    digit = 7
    expected_increase = @lock.size + @lock.digits.first + @lock.size - digit + @lock.clicks
    @lock.enter_digit(digit)
    assert_equal expected_increase, @lock.clicks
  end

  def test_third_digit_increases_clicks_by_absolute_value_of_second_value_less_third
    @lock.size = 12
    @lock.enter_digit(5)
    @lock.enter_digit(7)
    digit = 9
    expected_increase = (@lock.digits[1] - digit).abs + @lock.clicks
    @lock.enter_digit(digit)
    assert_equal expected_increase, @lock.clicks
  end
end
