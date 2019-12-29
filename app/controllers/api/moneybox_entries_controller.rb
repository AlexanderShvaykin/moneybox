# frozen_string_literal: true

module Api
  class MoneyboxEntriesController < ApplicationController
    def create
      render_result(Moneyboxes::CreateOperation.new(**params).call)
    end
  end
end
