# README

This README would normally document whatever steps are necessary to get the
application up and running.

Architectural Decisions
Models and Associations
User Model
Attributes:
name: The name of the user.
status: The status of the user, restricted to "active" or "inactive".
email: The email address of the user, must be unique and follow the standard email format.
number: The contact number of the user, stored as a string.

Associations:

A user can have multiple borrowed books (has_many :borrowed_books).

Book Model

Attributes:
title: The title of the book.
author: The author of the book.
copies: The number of copies available for the book.
isbn: The ISBN (International Standard Book Number) of the book, must be unique.

Associations:
A book can be borrowed by multiple users through the borrowed_books association (has_many :borrowed_books).

API Details

Endpoints

Books
GET /books:
Returns a list of all books in the library.

POST /books:
Creates a new book with the provided parameters.
Required parameters: title, author, copies, isbn.
Example request body:

{
  "title": "Sample Book",
  "author": "Sample Author",
  "copies": 5,
  "isbn": "1234567890"
}

POST /books/:id/borrow:
Allows a user to borrow a book from the library.
Required parameters: user_id, book_id.
Example request body:
{
  "user_id": 1,
}

DELETE /books/:id:/return
Allows a user to return a borrowed book to the library.
Requires the ID of the borrowed book to be returned as a path parameter.

Testing Approach

RSpec Tests:
Model-level validations are tested using RSpec.
Controller actions are tested using request specs in RSpec to ensure correct behavior of API endpoints.

