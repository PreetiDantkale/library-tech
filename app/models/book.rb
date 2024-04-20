class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :copies, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :isbn, presence: true, uniqueness: true

  has_many :borrowed_books

  def copies_available
    copies - borrowed_books.count
  end
end
