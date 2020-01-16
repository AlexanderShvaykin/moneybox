# frozen_string_literal: true

module Moneyboxes
  class UpdateOperation < ApplicationOperation
    schema do
      required(:name).filled(:string)
    end

    def call
      values = yield validate_schema
      find_result = yield ::FindOperation.new(params).call(MoneyboxEntry)
      moneybox = yield save(find_result.last, values)

      Success([:ok, moneybox])
    end

    def save(record, values)
      record.update!(values)
      Success(record)
    end
  end
end
