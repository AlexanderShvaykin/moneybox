# frozen_string_literal: true

class TokensController < ApplicationController
  skip_before_action :authenticate_request

  def create
    render_result(Users::AuthenticateOperation.new(**params).call)
  end
end
