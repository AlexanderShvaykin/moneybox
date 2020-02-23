# frozen_string_literal: true

module Api
  class FinanceGoalsController < ApplicationController
    def index
      operation = FinanceGoals::IndexOperation.new(**params)
      render_result operation.call(moneybox_repo) do |finance_goals|
        render json: FinanceGoalSerializer.new(finance_goals, is_collection: true)
      end
    end

    def create
      operation = FinanceGoals::CreateOperation.new(**params)
      render_result operation.call(moneybox_repo) do |finance_goal|
        render json: FinanceGoalSerializer.new(finance_goal)
      end
    end

    def show
      repo = FinanceGoalRepository.new(current_user)
      render_result(FindOperation.new(id: params[:id]).call(repo)) do |finance_goal|
        render json: FinanceGoalSerializer.new(finance_goal)
      end
    end

    def update
      operation = FinanceGoals::UpdateOperation.new(**params)
      render_result operation.call(finance_goal_repo) do |finance_goal|
        render json: FinanceGoalSerializer.new(finance_goal)
      end
    end

    def destroy
      render_result(DestroyOperation.new(**params).call(finance_goal_repo))
    end

    private

    def moneybox_repo
      MoneyboxEntryRepository.new(current_user)
    end

    def finance_goal_repo
      FinanceGoalRepository.new(current_user)
    end
  end
end
