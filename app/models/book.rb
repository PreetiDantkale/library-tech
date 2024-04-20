class Book < ApplicationRecord
  has_many :borrowed_books

  def copies_available
    copies - borrowed_books.count
  end
end
