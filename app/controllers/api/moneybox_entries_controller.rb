# frozen_string_literal: true

module Api
  class MoneyboxEntriesController < ApplicationController
    def index
      run_operation(Moneyboxes::IndexOperation.new(**params).call) do |boxes|
        render json: MoneyboxSerializer.new(boxes, is_collection: true)
      end
    end

    def create
      operation = Moneyboxes::CreateOperation.new(user: current_user, **params)
      run_operation(operation.call) do |box, status|
        render json: MoneyboxSerializer.new(box), status: status
      end
    end

    def show
      run_operation(FindOperation.new(**params).call(MoneyboxEntry)) do |box|
        render json: MoneyboxSerializer.new(box)
      end
    end

    def update
      run_operation(Moneyboxes::UpdateOperation.new(**params).call) do |box|
        render json: MoneyboxSerializer.new(box)
      end
    end

    def destroy
      run_operation(Moneyboxes::DestroyOperation.new(**params).call)
    end
  end
end
