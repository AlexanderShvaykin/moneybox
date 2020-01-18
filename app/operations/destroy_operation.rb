# frozen_string_literal: true

class DestroyOperation < ApplicationOperation
  def call(repo)
    find_result = yield ::FindOperation.new(id: params[:id]).call(repo)
    moneybox = find_result.last
    moneybox.destroy!
    Success([:ok, ""])
  end
end
