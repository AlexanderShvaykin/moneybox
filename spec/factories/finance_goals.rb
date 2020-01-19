# frozen_string_literal: true

FactoryBot.define do
  factory :finance_goal do
    started_at { Time.current }
    finished_at { 1.month.from_now }
    moneybox_entry
  end
end
