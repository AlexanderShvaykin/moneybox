# frozen_string_literal: true

class ApplicationController < ActionController::API
  def params
    super.to_unsafe_hash
  end

  private

  def render_result(result)
    case result
    in Dry::Monads::Result::Success[(Integer | Symbol) => status, entity]
      render json: entity, status: status
    in Dry::Monads::Result::Failure[(Integer | Symbol) => status, ActiveModel::Errors => errors]
      render json: [errors: errors.to_h], status: status
    in Dry::Monads::Result::Failure[(Integer | Symbol) => status, Hash => payload]
      render json: {errors: payload}, status: status
    else
      raise ArgumentError, "invalid operation result"
    end
  end
end
