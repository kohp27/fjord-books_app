# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "user_#{i}" }
    sequence(:email) { |i| "user_#{i}@emample.com" }
    password { 'password' }
  end
end
