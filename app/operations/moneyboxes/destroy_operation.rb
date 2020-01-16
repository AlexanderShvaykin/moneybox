# frozen_string_literal: true

module Moneyboxes
  class DestroyOperation < ApplicationOperation
    def call
      find_result = yield ::FindOperation.new(params).call(MoneyboxEntry)
      moneybox = find_result.last
      moneybox.destroy!
      Success([:ok, ""])
    end
  end
end
