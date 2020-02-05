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

    def update
      operation = FinanceGoals::UpdateOperation.new(**params)
      run_operation operation.call(current_user_goals) do |finance_goal|
        render json: FinanceGoalSerializer.new(finance_goal)
      end
    end

    def destroy
      run_operation(DestroyOperation.new(**params).call(current_user_goals))
    end

    private

    def current_user_goals
      @current_user_goals ||= FinanceGoal.where(moneybox: current_user.moneybox_entries)
    end
  end
end
