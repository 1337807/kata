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

class CoinStacker
  def coin_piles_for_amount_in_denominations(amount, denominations)
    sorted = denominations.sort.reverse

    max = (amount / denomination)
    max.times do |count|
    end
  end
end

class CoinStackerTest < Test::Unit::TestCase
  def setup
    @stacker = CoinStacker.new
    @currency = Currency.new
  end

  def _test_coin_piles_for_currency
    @currency.parse_denominations('1 5')
    result = @stacker.coin_piles_for_amount_in_denominations(10, @currency.denominations)
    assert_equal [[[1, 5], [5, 1], [5, 2], [1, 10]], result
  end
end
