# frozen_string_literal: true

class Api::PlanedExpensesController < ApplicationController
  def index
    operation = FinanceGoals::PlanedExpenses::IndexOperation.new(**params)
    run_operation operation.call(FinanceGoal) do |planed_expenses|
      render json: PlanedExpenseSerializer.new(planed_expenses, is_collection: true)
    end
  end

  def create

  end
end
