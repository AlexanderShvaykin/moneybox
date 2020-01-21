# frozen_string_literal: true

module Api
  class FinanceGoalsController < ApplicationController
    def index
      operation = FinanceGoals::IndexOperation.new(**params)
      run_operation operation.call(MoneyboxEntry) do |finance_goals|
        render json: FinanceGoalSerializer.new(finance_goals, is_collection: true)
      end
    end
  end
end
