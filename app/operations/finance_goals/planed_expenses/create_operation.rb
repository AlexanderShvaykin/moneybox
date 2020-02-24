# frozen_string_literal: true

class FinanceGoals::PlanedExpenses::CreateOperation < ApplicationOperation
  schema do
    required(:amount).value(:integer)
    required(:name).filled(:string)
  end

  def call(repo = FinanceGoalRepository.new(user))
    goal = yield(::FindOperation.new(id: params[:finance_goal_id]).call(repo)).last
    values = yield validate_schema
    record = yield create_expense(goal, values)

    Success([:created, record])
  end

  private

  def create_expense(goal, values)
    expense = goal.planed_expenses.new(values)
    goal.increment(:payment_amount, expense.amount)
    ApplicationRecord.transaction do
      expense.save!
      goal.save!
    end
    Success(expense)
  end
end
