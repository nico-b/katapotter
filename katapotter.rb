#!/usr/bin/env ruby

def count_different_books(books)
  diff_books = Hash.new 0

  books.each do |b|
    diff_books[b] += 1
  end

  diff_books

end

def group_books_for_discount(books_cart, max_size)

  books_gathered_for_discount = []
  books_gathered_for_discount << []

  count_books = count_different_books books_cart

  #required to be sorted by number of same books to group them correctly
  books_cart.sort! { |a, b| count_books[b] <=> count_books[a] }

  while books_cart.length > 0
    next_book = books_cart.shift

    inserted = false

    books_gathered_for_discount.each do |g|
      if !g.include?(next_book) && !inserted && g.length < max_size
        g << next_book
        inserted = true
      end
    end

    books_gathered_for_discount << [next_book] if !inserted

  end

  books_gathered_for_discount

end

def price_after_discount(books_cart)

  book_price = 8
  discount = {0 => 0, 1 => 1, 2 => 0.95, 3 => 0.90, 4 => 0.80, 5 => 0.75}
  min_discount_size = 2
  max_discount_size = 5

  lower_price = books_cart.length * book_price #initialized to max possible price

  (min_discount_size..max_discount_size).each do |max_size|
    discount_groups = group_books_for_discount(books_cart.dup, max_size)
    price = 0
    discount_groups.each do |g|
      price += book_price * g.length * discount[g.length]
    end
    lower_price = price if price < lower_price
  end

  return lower_price

end
