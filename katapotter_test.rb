require 'test/unit'
require_relative 'katapotter'

class KatapotterTest < Test::Unit::TestCase

  def test_with_0_tome()
    book_cart = BookCart.new []
    assert_equal 0, book_cart.price_after_discount
  end

  def test_with_1_tome()
    book_cart = BookCart.new [1]
    assert_equal 8, book_cart.price_after_discount
  end

  def test_with_2_tomes()
    book_cart = BookCart.new [1, 2]
    assert_equal 8 * 2 * 0.95, book_cart.price_after_discount
  end

  def test_with_3_tomes()
    book_cart = BookCart.new [1, 2, 3]
    assert_equal 8 * 3 * 0.90, book_cart.price_after_discount
  end

  def test_with_4_tomes()
    book_cart = BookCart.new [1, 2, 3, 4]
    assert_equal 8 * 4 * 0.80, book_cart.price_after_discount
  end

  def test_with_5_tomes()
    book_cart = BookCart.new [1, 2, 3, 4, 5]
    assert_equal 8 * 5 * 0.75, book_cart.price_after_discount
  end

  def test_with_2_same_tomes()
    book_cart = BookCart.new [1, 1]
    assert_equal 8 * 2, book_cart.price_after_discount
  end

  def test_with_2_same_tomes_and_3_differents()
    book_cart = BookCart.new [1, 1, 2, 3]
    assert_equal 8 + 8 * 3 * 0.90, book_cart.price_after_discount
  end

  def test_with_2_same_tomes_and_4_differents()
    book_cart = BookCart.new [1, 1, 2, 3, 4]
    assert_equal 8 + 8 * 4 * 0.80, book_cart.price_after_discount
  end

  def test_with_2_same_tomes_and_5_differents()
    book_cart = BookCart.new [1, 1, 2, 3, 4, 5]
    assert_equal 8 + 8 * 5 * 0.75, book_cart.price_after_discount
  end

  def test_with_3_same_tomes_and_5_differents()
    book_cart = BookCart.new [1, 1, 1, 2, 3, 4, 5]
    assert_equal 8 * 2 + 8 * 5 * 0.75, book_cart.price_after_discount
  end

  def test_complex()
    book_cart = BookCart.new [1, 1, 2, 2, 3, 3, 4, 5]
    assert_equal 8 * 4 * 0.80 + 4 * 8 * 0.80, book_cart.price_after_discount
  end

  def test_complex_2()
    book_cart = BookCart.new [1, 2, 2, 3, 3, 4, 5, 5]
    assert_equal 8 * 4 * 0.80 + 4 * 8 * 0.80, book_cart.price_after_discount
  end

  def test_complex_3()
    book_cart = BookCart.new [1, 1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 5]
    assert_equal 78.80, book_cart.price_after_discount
  end

end

