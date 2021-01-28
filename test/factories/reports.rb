# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    user
    sequence(:title) { |i| "title_#{i}" }
    sequence(:content) { |i| "content_#{i}" }
  end
end
