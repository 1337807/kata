require 'test/unit'

class Checksum
  def binary(word)
    "Jonan".bytes.map { |letter| letter.to_s(2) }.join
  end
end

class ChecksumTest < Test::Unit::TestCase
  def setup
    @checksum = Checksum.new
  end

  def test_binary_converts_given_string_to_binary
    result = @checksum.binary("Jonan")
    assert_equal '10010101101111110111011000011101110', result
  end
end
