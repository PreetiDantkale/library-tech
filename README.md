# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:


Certainly! Here's an improved version of the architectural decisions section in the README file:

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

Testing Approach

RSpec Tests:
Model-level validations are tested using RSpec.
Controller actions are tested using request specs in RSpec to ensure correct behavior of API endpoints.

