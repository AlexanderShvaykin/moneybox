# frozen_string_literal: true

class PlanedExpense < ApplicationRecord
  belongs_to :goal, class_name: "FinanceGoal", foreign_key: "finance_goal_id"
end
