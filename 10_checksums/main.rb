require 'test/unit'

class Checksum
  def binary(word)
    word.bytes.map { |letter| letter.to_s(2) }.join
  end

  def binary_blocks(word)
    binary(word).scan(/.{1,#{8}}/)
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

  def test_binary_blocks_converts_given_string_into_eight_bit_blocks
    result = @checksum.binary_blocks("Rad")
    assert_equal ["10010101", "10111111", "01110110", "00011101", "110"], result
  end
end
