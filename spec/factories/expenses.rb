FactoryBot.define do
  factory :expense do
    name { "MyString" }
    amount { 1 }
    planed_expenses { nil }
  end
end
