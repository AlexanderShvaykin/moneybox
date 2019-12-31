module Moneyboxes
  class DestroyOperation < ApplicationOperation
    def call
      find_result = yield ::FindOperation.new(params).call(MoneyboxEntry)
      moneybox = find_result.last
      moneybox.delete ? Success([:ok, '']) : Failure([:unprocessable_entity, moneybox.errors])
    end
  end
end
