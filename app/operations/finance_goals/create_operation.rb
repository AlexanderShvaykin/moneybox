# frozen_string_literal: true

module FinanceGoals
  class CreateOperation < ApplicationOperation
    schema do
      required(:payment_amount).value(:integer)
      required(:income_amount).value(:integer)
      required(:started_at).value(:integer)
      required(:finished_at).value(:integer)
    end

    def call(repo)
      find_result = yield ::FindOperation.new(id: params[:moneybox_id]).call(repo)
      values = yield validate_schema

      find_result.last.finance_goals.create!(values)
    end
  end
end
