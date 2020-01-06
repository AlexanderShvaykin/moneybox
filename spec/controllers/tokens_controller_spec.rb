# frozen_string_literal: true

describe TokensController do
  describe "POST #create" do
    specify  do
      expect(post: "/tokens")
          .to route_to(controller: "tokens", action: "create")
    end

    context "with user" do
      subject { post :create, format: :as_json, params: params }

      let_it_be(:user) { create :user, secret: "secret" }
      let(:params) { Hash[email: user.email, password: "secret"] }

      before do
        allow(JsonWebToken).to receive(:encode).with(user_id: user.id).and_return("some_token")
      end

      it "returns token" do
        expect(subject.body).to include_json(token: "some_token")
      end
    end
  end
end
