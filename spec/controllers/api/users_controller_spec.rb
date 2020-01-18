# frozen_string_literal: true

describe Api::UsersController, :with_auth_user do
  describe "GET #me" do
    specify  do
      expect(get: "/api/users/me")
          .to route_to(controller: "api/users", action: "me")
    end

    subject { get :me }

    it "returns current user" do
      expect(subject.body).to include_json(data: { id: user.id.to_s })
    end
  end
end
