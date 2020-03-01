# frozen_string_literal: true

class ApplicationController < ActionController::API
  include AbstractController::Callbacks

  before_action :authenticate_request

  # Overwrite controller params, all validation calls into operation
  # @return [Hash]
  def params
    super.to_unsafe_hash
  end

  # Render operation result payload with result
  # @example
  #   render_result(Users::AuthenticateOperation.new(**params).call
  #   # or
  #   render_result operation.call(moneybox_repo) do |finance_goals|
  #     render json: FinanceGoalSerializer.new(finance_goals, is_collection: true)
  #   end
  # @param result [Dry::Monads::Result] Operation Result
  # @yield render payload with serializer
  def render_result(result)
    case result
    in Dry::Monads::Result::Success[(Integer | Symbol) => status, entity]
      block_given? ? yield(entity, status) : render(json: entity, status: status)
    in Dry::Monads::Result::Failure[(Integer | Symbol) => status, Array => errors]
      render json: { errors: serialize_errors(errors) }, status: status
    else
      raise ArgumentError, "invalid operation result"
    end
  end

  private

  def serialize_errors(errors)
    errors.map do |e|
      { title: e.fetch(:title, I18n.t("errors.main_error")) }
          .merge(Hash[message: e[:message]].compact)
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
