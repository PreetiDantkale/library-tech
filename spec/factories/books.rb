FactoryBot.define do
  factory :book do
    title { "MyString" }
    author { "MyString" }
    copies { 1 }
    isbn { "MyString" }
  end
end