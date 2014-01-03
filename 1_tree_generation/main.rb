require 'test/unit'

class Tree
  attr_reader :trunk, :base_length, :leaf

  def initialize(base_length, trunk, leaf)
    @base_length, @trunk, @leaf = base_length, trunk, leaf
  end

  def output
    leaf_output + trunk_output
  end

  def leaf_output
    base = self.leaf * self.base_length
    grow(base)
  end

  def grow(base)
    final = "#{base}\n"

    padding = " "

    while base.length > 1
      base = base.slice(1..-2)
      final = "#{padding}#{base}#{padding}\n" + final
      padding += " "
    end

    final
  end

  def trunk_output
    wood = self.trunk * 3
    padding = " " * (self.base_length / 2 - 1)
    "#{padding}#{wood}#{padding}"
  end
end

class TreeTest < Test::Unit::TestCase
  def setup
    @tree = Tree.new(3,'%','~')
    @big_tree = Tree.new(7,'&','$')
  end

  def test_leaf_output
    assert_equal " ~ \n~~~\n", @tree.leaf_output
  end

  def test_grow
    assert_equal "  +  \n +++ \n+++++\n", @tree.grow('+++++')
  end

  def test_trunk_output
    assert_equal '%%%', @tree.trunk_output
  end

  def test_trunk_output_pads_for_length
    assert_equal "  &&&  ", @big_tree.output.split("\n").last
  end

  def test_tree_output_includes_trunk
    assert_equal '%%%', @tree.output.split.last
  end

  def test_tree_output
    expected = "   $   \n  $$$  \n $$$$$ \n$$$$$$$\n  &&&  "
    assert_equal expected, @big_tree.output
  end
end
