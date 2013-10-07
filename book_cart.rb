class BookCart

  attr_accessor :books

  BOOK_PRICE = 8
  DISCOUNT = {0 => 0, 1 => 1, 2 => 0.95, 3 => 0.90, 4 => 0.80, 5 => 0.75}
  MIN_DISCOUNT_GROUP_SIZE = 2
  MAX_DISCOUNT_GROUP_SIZE = 5

  #
  # Constructor
  # * *Args*    :
  #     - +books+ -> Books to be added to cart
  # * *Raises* :
  #     - Argument error if provided Books are not in [1,2,3,4,5]
  #
  def initialize(books)

    if books.index {|b| b <= 0 || b > 5}
      raise ArgumentError.new 'None of these books has ever been written!!'
    end

    @books = books
  end

  #
  # Method used to calculate the cart price after discount
  # * *Returns* :
  #     - the total price (float), including discount, for the provided cart
  #
  def price_after_discount

    lower_price = @books.length * BOOK_PRICE #initialized to max possible price, in any case, result shoud be = or <

    (MIN_DISCOUNT_GROUP_SIZE..MAX_DISCOUNT_GROUP_SIZE).each do |max_size|
      discount_groups = group_books_for_discount(@books.dup, max_size)
      price = 0
      discount_groups.each do |g|
        price += BOOK_PRICE * g.length * DISCOUNT[g.length]
      end
      lower_price = price if price < lower_price
    end

    return lower_price

  end

  private

    #
    # Method used to count number of books of each type
    # * *Returns* :
    #     - a Hash of with key = Book Number and value = number of books
    #
    def count_different_books

      diff_books = Hash.new 0

      @books.each do |b|
        diff_books[b] += 1
      end

      diff_books

    end

    #
    # Method used to group books for discount
    # * *Args*    :
    #     - +books+ -> Books Array to use for grouping discount purpose
    #     - +max_size+ -> Maximum size for a books group
    # * *Returns* :
    #     - an array of books group, for ex. [[1,2,3,4], [1,5,2]]
    #
    def group_books_for_discount(books, max_size)

      books_gathered_for_discount = []
      books_gathered_for_discount << []

      count_books = count_different_books

      #required to be sorted by number of same books to group them correctly
      books.sort! { |a, b| count_books[b] <=> count_books[a] }

      while books.length > 0
        next_book = books.shift

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

end
