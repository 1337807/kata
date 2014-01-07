require 'test/unit'

class Currency
  attr_reader :denominations

  def parse_denominations(coin_list)
    @denominations = coin_list.split.map(&:to_i)
  end
end

class CurrencyTest < Test::Unit::TestCase
  def setup
    @currency = Currency.new
  end

  def test_parse_currency
    @currency.parse_denominations('1 5 10 25 50 100')
    assert_equal [1, 5, 10 , 25, 50, 100], @currency.denominations
  end
end
