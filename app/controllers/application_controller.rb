# frozen_string_literal: true

class ApplicationController < ActionController::API
  include AbstractController::Callbacks

  before_action :authenticate_request

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
    in Dry::Monads::Result::Failure[(Integer | Symbol) => status, String => message]
      render json: {message: message}, status: status
    else
      raise ArgumentError, "invalid operation result"
    end
  end

  def current_user
    return @current_user if defined? @current_user

    result = AuthorizeApiOperation.new(request.headers).call
    if result.success?
      @current_user = result.value!.last
    else
      render_result(result)
    end
  end
  alias_method :authenticate_request, :current_user
end
