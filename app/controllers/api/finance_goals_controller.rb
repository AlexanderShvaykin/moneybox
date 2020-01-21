# frozen_string_literal: true

module Api
  class FinanceGoalsController < ApplicationController
    def index
      operation = FinanceGoals::IndexOperation.new(**params)
      run_operation operation.call(current_user.moneybox_entries) do |finance_goals|
        render json: FinanceGoalSerializer.new(finance_goals, is_collection: true)
      end
    end

    def create
      operation = FinanceGoals::CreateOperation.new(**params)
      run_operation operation.call(current_user.moneybox_entries) do |finance_goal|
        render json: FinanceGoalSerializer.new(finance_goal)
      end
    end
  end
end
