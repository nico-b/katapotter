require 'test/unit'
require_relative 'katapotter'

class KatapotterTest < Test::Unit::TestCase

  def test_with_0_tome()
    books = []
    assert_equal 0, price_after_discount(books)
  end

  def test_with_1_tome()
    books = [1]
    assert_equal 8, price_after_discount(books)
  end

  def test_with_2_tomes()
    books = [1, 2]
    assert_equal 8 * 2 * 0.95, price_after_discount(books)
  end

  def test_with_3_tomes()
    books = [1, 2, 3]
    assert_equal 8 * 3 * 0.90, price_after_discount(books)
  end

  def test_with_4_tomes()
    books = [1, 2, 3, 4]
    assert_equal 8 * 4 * 0.80, price_after_discount(books)
  end

  def test_with_5_tomes()
    books = [1, 2, 3, 4, 5]
    assert_equal 8 * 5 * 0.75, price_after_discount(books)
  end

  def test_with_2_same_tomes()
    books = [1, 1]
    assert_equal 8 * 2, price_after_discount(books)
  end

  def test_with_2_same_tomes_and_3_differents()
    books = [1, 1, 2, 3]
    assert_equal 8 + 8 * 3 * 0.90, price_after_discount(books)
  end

  def test_with_2_same_tomes_and_4_differents()
    books = [1, 1, 2, 3, 4]
    assert_equal 8 + 8 * 4 * 0.80, price_after_discount(books)
  end

  def test_with_2_same_tomes_and_5_differents()
    books = [1, 1, 2, 3, 4, 5]
    assert_equal 8 + 8 * 5 * 0.75, price_after_discount(books)
  end

  def test_with_3_same_tomes_and_5_differents()
    books = [1, 1, 1, 2, 3, 4, 5]
    assert_equal 8 * 2 + 8 * 5 * 0.75, price_after_discount(books)
  end

  def test_complex()
    books = [1, 1, 2, 2, 3, 3, 4, 5]
    assert_equal 8 * 4 * 0.80 + 4 * 8 * 0.80, price_after_discount(books)
  end

  def test_complex_2()
    books = [1, 2, 2, 3, 3, 4, 5, 5]
    assert_equal 8 * 4 * 0.80 + 4 * 8 * 0.80, price_after_discount(books)
  end

end

