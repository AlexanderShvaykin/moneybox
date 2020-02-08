# frozen_string_literal: true

describe Users::AuthenticateOperation do
  describe "#call" do
    subject(:auth_user) { described_class.new(params).call }
    let(:params) { Hash[email: email, password: password] }
    let(:email) { "test@moneybox.org" }
    let(:password) { "secret" }

    describe "unit tests" do
      let(:user) { instance_double(User, authenticate: true, id: 123) }

      before do
        allow(User).to receive(:find_by).with(email: "test@moneybox.org").and_return(user)
        allow(JsonWebToken).to receive(:encode).with(user_id: 123).and_return("some_token")
      end

      it "returns ok code and user" do
        expect(subject.value!).to eq [:ok, token: "some_token"]
      end

      context "without email" do
        let(:params) { Hash[password: password] }

        it "returns error and payload" do
          expect(subject.failure).to contain_exactly :bad_request, instance_of(Array)
        end
      end

      context "when user not found" do
        before do
          allow(User).to receive(:find_by).with(email: "test@moneybox.org").and_return(nil)
        end

        it "returns error and payload" do
          expect(subject.failure).to contain_exactly :unauthorized, []
        end
      end

      context "when not authorized" do
        let(:user) { instance_double(User, authenticate: false) }

        it "returns error and payload" do
          expect(subject.failure).to contain_exactly :unauthorized, []
        end
      end
    end
  end
end
