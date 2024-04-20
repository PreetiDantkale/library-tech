class CreateBorrowedBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :borrowed_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :returned_at

      t.timestamps
    end
  end
end
