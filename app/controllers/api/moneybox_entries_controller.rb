# frozen_string_literal: true

module Api
  class MoneyboxEntriesController < ApplicationController
    def create
      render_result(Moneyboxes::CreateOperation.new(**params).call)
    end

    def show
      render_result(FindOperation.new(**params).call(MoneyboxEntry))
    end

    def update
      render_result(Moneyboxes::UpdateOperation.new(**params).call)
    end
  end
end
