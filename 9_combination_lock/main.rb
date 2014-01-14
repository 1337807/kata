require 'test/unit'

class Lock
  attr_accessor :size, :digits, :clicks

  def initialize(size = nil)
    @size = nil
    @digits = []
    @clicks = 0
  end

  def enter_digit(digit)
    self.clicks += self.size * 2 + digit if self.digits.empty?
    self.digits << digit
  end
end

class LockTest < Test::Unit::TestCase
  def setup
    @lock = Lock.new
  end

  def test_entering_the_first_digit_increases_the_clicks_by_twice_the_size
    @lock.size = 7
    digit = 5
    expected_increase = 2 * @lock.size + digit
    @lock.enter_digit(digit)
    assert_equal expected_increase, @lock.clicks
  end
end
