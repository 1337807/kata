require 'test/unit'

class List
  attr_accessor :items

  def initialize
    @items = {}
  end

  def add_item(name, price)
    self.items[name] = price
  end

  def compare(other_list)
    result = {}

    self.items.each do |key, value|
      if other_value = other_list.items[key]
        result[key] = convert_price_to_signed_price(other_value - value)
      end
    end

    result
  end

  def convert_price_to_signed_price(price)
    signed = price.to_s
    signed = '+' + signed unless signed.include? '-'
    signed
  end
end

class ListTest < Test::Unit::TestCase
  def setup
    @list = List.new
  end

  def test_add_item
    @list.add_item('CarriageBolt', 45)
    expected = { 'CarriageBolt' => 45 }
    assert_equal expected, @list.items
  end

  def test_compare_lists_detects_overpricing
    @list.add_item('Gizmo', 10)
    list2 = List.new
    list2.add_item('Gizmo', 5)

    expected = { 'Gizmo' => '-5' }
    assert_equal expected, @list.compare(list2)
  end

  def test_compare_lists_detects_underpricing
    @list.add_item('Gizmo', 5)
    list2 = List.new
    list2.add_item('Gizmo', 10)

    expected = { 'Gizmo' => '+5' }
    assert_equal expected, @list.compare(list2)
  end

  def test_compare_list_ignores_orphaned_items
    @list.add_item('Gizmo', 5)
    list2 = List.new
    list2.add_item('Gremlin', 10)

    expected = {}
    assert_equal expected, @list.compare(list2)
  end

  def test_convert_price_to_signed_price
    result = @list.convert_price_to_signed_price(-5)
    assert_equal '-5', result
  end

  def test_compare_list
    @list.add_item('Gizmo', 5)
    @list.add_item('Gremlin', 500)
    list2 = List.new
    list2.add_item('Gizmo', 100)
    list2.add_item('Gremlin', 100)

    expected = { 'Gizmo' => '+95', 'Gremlin' => '-400' }
    assert_equal expected, @list.compare(list2)
  end
end
