# frozen_string_literal: true

module FinanceGoals
  class IndexOperation < ApplicationOperation
    def call
      moneybox = yield ::FindOperation.new(id: params[:moneybox_id]).call(MoneyboxEntry)

      Success([:ok, moneybox.last.finance_goals])
    end
  end
end
