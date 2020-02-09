# frozen_string_literal: true

class FinanceGoals::PlanedExpenses::IndexOperation < ApplicationOperation
  def call(repo)
    goal = yield(::FindOperation.new(id: params[:finance_goal_id]).call(repo)).last

    Success([:ok, goal.planed_expenses.order(:id)])
  end
end
