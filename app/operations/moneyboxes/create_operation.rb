module Moneyboxes
  class CreateOperation < ApplicationOperation
    schema do
      required(:name).filled(:string)
    end

    def call
      values = yield validate
      moneybox = yield save(values)

      Success([:created, moneybox])
    end

    def save(values)
      MoneyboxEntry.new(values).then do |entity|
        entity.save ? Success(entity) : Failure([:unprocessable_entity, entity.errors])
      end
    end
  end
end
