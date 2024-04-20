class User < ApplicationRecord
  validates :name, presence: true
  validates :status, inclusion: { in: %w(active inactive) }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :number, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :borrowed_books
end
