# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def me
      render_result(FindOperation.new(id: current_user.id).call(User)) do |user|
        render json: UserSerializer.new(user)
      end
    end
  end
end
