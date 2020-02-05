# frozen_string_literal: true

module FinanceGoals
  class CreateOperation < ApplicationOperation
    schema do
      optional(:payment_amount).maybe(:integer)
      optional(:income_amount).maybe(:integer)
      required(:started_at).value(:date)
      required(:finished_at).value(:date)
    end

    def call(repo)
      find_result = yield ::FindOperation.new(id: params[:moneybox_id]).call(repo)
      values = yield validate_schema
      record = yield save_record(find_result.last, values)

      Success([:created, record])
    end

    private

    def save_record(moneybox, values)
      form = FinanceGoalForm.new(goal: moneybox.finance_goals.build, **values)
      if form.save
        Success(form.goal)
      else
        Failure([:unprocessable_entity, form.serialized_errors])
      end
    end
  end
end
