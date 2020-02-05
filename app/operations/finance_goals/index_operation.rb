# frozen_string_literal: true

module FinanceGoals
  class IndexOperation < ApplicationOperation
    def call(repo)
      moneybox = yield(::FindOperation.new(id: params[:moneybox_id]).call(repo)).last

      Success([:ok, moneybox.finance_goals.order(:started_at, :id)])
    end
  end
end
