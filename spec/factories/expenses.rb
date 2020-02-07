# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    name { "MyString" }
    amount { 1 }
    planed_expenses { nil }
  end
end
