# frozen_string_literal: true

class FinanceGoals::PlanedExpenses::CreateOperation < ApplicationOperation
  def call(repo)
    Success([:created, repo.last])
  end
end
