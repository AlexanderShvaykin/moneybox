# frozen_string_literal: true

module Users
  class AuthenticateOperation < ApplicationOperation
    schema do
      required(:email).filled(:string)
      required(:password).filled(:string)
    end

    def call
      values = yield validate
      user = yield auth_user(values)
      Success([:ok, token: JsonWebToken.encode(user_id: user.id)])
    end

    private

    def auth_user(values)
      user = User.find_by(email: values[:email])
      return Success(user) if user && user.authenticate(values[:password])

      Failure([:unauthorized, ""])
    end
  end
end
