require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe "GET #index" do
    context "when there are no books in the library" do
      it "returns a message indicating the library is empty" do
        get :index
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("The library is empty")
      end
    end

    context "when there are books in the library" do
      let!(:books) { create_list(:book, 3) }

      it "returns a list of books in the library" do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
  end

  describe "POST #borrow" do
    let(:user) { create(:user) }
    let(:book) { create(:book, copies: 5) }

    context "when the user has not reached borrowing limit" do
      it "adds the book to the user's borrowed list and removes it from the library" do
        post :borrow, params: { id: book.id, user_id: user.id }
        expect(response).to have_http_status(:created)
        expect(response.body).to include("Book borrowed successfully")
        expect(user.borrowed_books.count).to eq(1)
        expect(book.reload.copies).to eq(4)
      end
    end

    context "when the user has reached borrowing limit" do
      before { create_list(:borrowed_book, 2, user: user, book: book) }

      it "returns an error" do
        post :borrow, params: { id: book.id, user_id: user.id  }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Borrowing limit reached")
        expect(user.borrowed_books.count).to eq(2)
        expect(book.reload.copies).to eq(5)
      end
    end

    context "when there are multiple copies available" do
      it "adds one copy of the book to the user's borrowed list and decrements the library copies" do
        post :borrow, params: { id: book.id, user_id: user.id  }
        expect(response).to have_http_status(:created)
        expect(response.body).to include("Book borrowed successfully")
        expect(user.borrowed_books.count).to eq(1)
        expect(book.reload.copies).to eq(4)
      end
    end

    context "when there is only one copy available" do
      before { book.update(copies: 1) }

      it "adds the book to the user's borrowed list and removes it from the library" do
        post :borrow, params: { id: book.id, user_id: user.id  }
        expect(response).to have_http_status(:created)
        expect(response.body).to include("Book borrowed successfully")
        expect(user.borrowed_books.count).to eq(1)
        expect(book.reload.copies).to eq(0)
      end
    end
  end

  describe "DELETE #return" do
    let(:user) { create(:user) }
    let(:book1) { create(:book, copies: 1) }
    let(:book2) { create(:book, copies: 1) }
    let!(:borrowed_book1) { create(:borrowed_book, user: user, book: book1) }
    let!(:borrowed_book2) { create(:borrowed_book, user: user, book: book2) }

    context "when returning one book" do
      it "removes the book from the user's borrowed list and increments the library copies" do
        delete :return, params: { id: borrowed_book1.id }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Book returned successfully")
        expect(user.borrowed_books.count).to eq(1)
        expect(book1.reload.copies).to eq(2)
      end
    end
    
    context "when returning both books" do
      it "empties the user's borrowed list and increments the library copies" do
        delete :return, params: { id: borrowed_book1.id }
        delete :return, params: { id: borrowed_book2.id }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Book returned successfully")
        expect(user.borrowed_books.count).to eq(0)
        expect(book1.reload.copies).to eq(2)
        expect(book2.reload.copies).to eq(2)
      end
    end
  end
end
