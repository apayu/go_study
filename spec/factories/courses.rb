# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { "my course" }
    price { 100.0 }
    association :currency
    association :category
    status { 'publish' }
    slug { 'test slug' }
    description { 'test description' }
    valid_period { 10 }
  end
end
