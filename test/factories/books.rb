# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    sequence(:title) { |i| "book_title#{i}" }
    sequence(:memo) { |i| "book_memo#{i}" }
    sequence(:author) { |i| "book_author#{i}" }
  end
end
