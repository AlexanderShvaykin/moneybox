# frozen_string_literal: true

module Api
  class FinanceGoalsController < ApplicationController
    def index
      run_operation FinanceGoals::IndexOperation.new(**params).call do |finance_goals|
        render json: FinanceGoalSerializer.new(finance_goals, is_collection: true)
      end
    end
  end
end
