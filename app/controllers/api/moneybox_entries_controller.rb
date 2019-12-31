# frozen_string_literal: true

module Api
  class MoneyboxEntriesController < ApplicationController
    def index
      render json: { data: MoneyboxEntry.all }
    end

    def create
      render_result(Moneyboxes::CreateOperation.new(**params).call)
    end

    def show
      render_result(FindOperation.new(**params).call(MoneyboxEntry))
    end

    def update
      render_result(Moneyboxes::UpdateOperation.new(**params).call)
    end

    def destroy
      render_result(Moneyboxes::DestroyOperation.new(**params).call)
    end
  end
end
