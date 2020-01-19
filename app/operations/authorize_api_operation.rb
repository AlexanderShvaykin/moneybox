# frozen_string_literal: true

class AuthorizeApiOperation < ApplicationOperation
  def initialize(headers = {})
    @headers = headers
  end

  def call
    header = yield http_auth_header
    decoded_token = yield decode_token(header)
    user = yield load_user(decoded_token)

    Success([:ok, user])
  end

  private

  def load_user(decoded_token)
    user = User.find_by(id: decoded_token[:user_id])
    user.nil? ? Failure([:unauthorized, [message: "User doesn't exist"]]) : Success(user)
  end

  def decode_token(header)
    token = JsonWebToken.decode(header)
    token.present? ? Success(token) : Failure([:unauthorized, [message: "Invalid token"]])
  end

  def http_auth_header
    if @headers["Authorization"].present?
      Success(@headers["Authorization"].split(" ").last)
    else
      Failure([:unauthorized, [message: "Missing token"]])
    end
  end
end
