module Moneyboxes
  class UpdateOperation < ApplicationOperation
    schema do
      required(:name).filled(:string)
    end

    def call
      values = yield validate
      find_result = yield ::FindOperation.new(params).call(MoneyboxEntry)
      moneybox = yield save(find_result.last, values)

      Success([:ok, moneybox])
    end

    def save(record, values)
      record.update(values) ? Success(record) : Failure([:unprocessable_entity, record.errors])
    end
  end
end