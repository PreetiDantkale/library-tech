# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Creating users
user1 = User.create(name: "John Doe")
user2 = User.create(name: "Jane Smith")

# Creating books
book1 = Book.create(title: "To Kill a Mockingbird", author: "Harper Lee", copies: 5)
book2 = Book.create(title: "1984", author: "George Orwell", copies: 3)
book3 = Book.create(title: "The Great Gatsby", author: "F. Scott Fitzgerald", copies: 7)
