class User < ApplicationRecord
  has_many :borrowed_books
end
