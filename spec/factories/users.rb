# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
    name { "MyString" }
    admin { false }

    transient do
      secret { "secret" }
    end

    before(:create) do |user, evaluator|
      user.password = evaluator.secret
      user.password_confirmation = evaluator.secret
    end
  end
end
