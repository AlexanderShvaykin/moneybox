# frozen_string_literal: true

class FinanceGoals::PlanedExpenses::DestroyOperation < ApplicationOperation
  def call(repo = PlanedExpensesRepository.new(user))
    expense = yield(::FindOperation.new(id: params[:id]).call(repo)).last
    goal = expense.goal
    ApplicationRecord.transaction do
      expense.destroy!
      goal.decrement(:payment_amount, expense.amount)
      goal.save!
    end
    Success([:ok, expense])
  end
end
