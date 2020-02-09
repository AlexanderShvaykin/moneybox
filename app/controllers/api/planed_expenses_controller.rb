# frozen_string_literal: true

class Api::PlanedExpensesController < ApplicationController
  def index
    operation = FinanceGoals::PlanedExpenses::IndexOperation.new(**params)
    render_result operation.call(FinanceGoal) do |planed_expenses|
      render json: PlanedExpenseSerializer.new(planed_expenses, is_collection: true)
    end
  end

  def create
    operation = FinanceGoals::PlanedExpenses::CreateOperation.new(**params)
    render_result operation.call(repo) do |planed_expense, status|
      render json: PlanedExpenseSerializer.new(planed_expense), status: status
    end
  end

  private

  def repo
    FinanceGoalRepository.new(current_user)
  end
end
