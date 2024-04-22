FactoryBot.define do
  factory :borrowed_book do
    user { nil }
    book { nil }
    returned_at { "2024-04-20 15:04:13" }
  end
end
