# frozen_string_literal: true

module Api
  class MoneyboxEntriesController < ApplicationController
    def index
      run_operation(Moneyboxes::IndexOperation.new(**params).call)
    end

    def create
      run_operation(Moneyboxes::CreateOperation.new(**params).call)
    end

    def show
      run_operation(FindOperation.new(**params).call(MoneyboxEntry))
    end

    def update
      run_operation(Moneyboxes::UpdateOperation.new(**params).call)
    end

    def destroy
      run_operation(Moneyboxes::DestroyOperation.new(**params).call)
    end
  end
end
