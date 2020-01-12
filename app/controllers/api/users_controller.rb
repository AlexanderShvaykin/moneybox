# frozen_string_literal: true
module Api
  class UsersController < ApplicationController
    def me
      render_result(FindOperation.new(id: current_user.id).call(User))
    end
  end
end
