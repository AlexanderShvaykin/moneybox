# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
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
