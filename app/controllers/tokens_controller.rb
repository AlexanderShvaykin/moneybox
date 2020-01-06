# frozen_string_literal: true

class TokensController < ApplicationController
  def create
    render_result(Users::AuthenticateOperation.new(params).call)
  end
end
