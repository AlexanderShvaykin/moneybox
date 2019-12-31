module Moneyboxes
  class IndexOperation < ApplicationOperation
    def call
      Success([:ok, MoneyboxEntry.all])
    end
  end
end
