# frozen_string_literal: true

class FinanceGoalSerializer < ApplicationSerializer
  attributes :payment_amount, :income_amount, :started_at, :finished_at
  attribute :month_number do |goal|
    goal.started_at.month
  end
end
