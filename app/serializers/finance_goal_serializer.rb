# frozen_string_literal: true

class FinanceGoalSerializer < ApplicationSerializer
  attributes :payment_amount, :income_amount, :started_at, :finished_at
  attribute :month_number do |goal|
    goal.started_at.month
  end

  has_many :planed_expenses, lazy_load_data: true, links: {
    related: -> (object) {
      url_helpers.api_finance_goal_planed_expenses_url(finance_goal_id: object.id)
    }
  }
end
