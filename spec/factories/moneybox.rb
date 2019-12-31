FactoryBot.define do
  factory :moneybox, class: MoneyboxEntry do
    name { Faker::Lorem.characters(number: 10) }
  end
end
