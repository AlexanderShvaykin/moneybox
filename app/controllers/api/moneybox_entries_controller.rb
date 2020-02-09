# frozen_string_literal: true

module Api
  class MoneyboxEntriesController < ApplicationController
    def index
      render json: MoneyboxSerializer.new(current_user.moneybox_entries, is_collection: true)
    end

    def create
      operation = Moneyboxes::CreateOperation.new(user: current_user, **params)
      render_result(operation.call) do |box, status|
        render json: MoneyboxSerializer.new(box), status: status
      end
    end

    def show
      render_result(FindOperation.new(id: params[:id]).call(current_user.moneybox_entries)) do |box|
        render json: MoneyboxSerializer.new(box)
      end
    end

    def update
      operation = Moneyboxes::UpdateOperation.new(user: current_user, **params)
      render_result(operation.call) do |box|
        render json: MoneyboxSerializer.new(box)
      end
    end

    def destroy
      render_result(DestroyOperation.new(**params).call(current_user.moneybox_entries))
    end
  end
end
