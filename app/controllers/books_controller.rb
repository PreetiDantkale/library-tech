# app/controllers/books_controller.rb
class BooksController < ApplicationController
  # GET /books
  def index
    books = Book.all
    if books.empty?
      render json: { message: "The library is empty" }, status: :ok
    else
      render json: books
    end
  end

  # POST /books/:id/borrow
  def borrow
    book = Book.find(params[:id])
    set_user
    if @user.borrowed_books.count >= 2
      render json: { error: "Borrowing limit reached" }, status: :unprocessable_entity
    elsif book.copies_available <= 0
      render json: { error: "No copies of the book available" }, status: :unprocessable_entity
    else
      borrowed_book = @user.borrowed_books.create(book: book)
      book.decrement!(:copies)
      render json: { message: "Book borrowed successfully", borrowed_book_id: borrowed_book.id }, status: :created
    end
  end
  
  # DELETE /books/:id/return
  def return
    borrowed_book = BorrowedBook.find_by(id: params[:id])
    if borrowed_book.nil?
      render json: { error: "Borrowed book not found" }, status: :not_found
    else
      book = borrowed_book.book
      borrowed_book.destroy
      book.increment!(:copies)
      render json: { message: "Book returned successfully" }, status: :ok
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
