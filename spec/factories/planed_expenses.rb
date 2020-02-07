# frozen_string_literal: true

FactoryBot.define do
  factory :planed_expense do
    name { "MyString" }
    amount { 1 }
    finance_goal { nil }
  end
end
