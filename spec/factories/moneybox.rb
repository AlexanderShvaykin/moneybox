# frozen_string_literal: true

FactoryBot.define do
  factory :moneybox, class: MoneyboxEntry do
    name { Faker::Lorem.characters(number: 10) }
    user
  end
end
