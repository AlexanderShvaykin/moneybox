# frozen_string_literal: true

class TokensController < ApplicationController
  skip_before_action :authenticate_request

  def create
    run_operation(Users::AuthenticateOperation.new(**params).call)
  end
end
