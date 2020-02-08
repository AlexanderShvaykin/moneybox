# frozen_string_literal: true

RSpec.shared_context "With auth user", with_auth_user: true do
  let_it_be(:user) { create :user }
  let(:auth_token) { JsonWebToken.encode(user_id: user.id) }

  before do
    request.headers.add("Authorization", auth_token)
  end
end

RSpec.shared_context "With auth user", with_api_user: true do
  let_it_be(:user) { create :user }
  let(:Authorization) { JsonWebToken.encode(user_id: user.id) }
end
