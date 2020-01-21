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
