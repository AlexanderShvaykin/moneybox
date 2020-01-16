# frozen_string_literal: true

module Moneyboxes
  class CreateOperation < ApplicationOperation
    schema do
      required(:name).filled(:string)
    end

    def call
      values = yield validate_schema
      moneybox = yield save(values)

      Success([:created, moneybox])
    end

    def save(values)
      Success(MoneyboxEntry.create!(values))
    end
  end
end
