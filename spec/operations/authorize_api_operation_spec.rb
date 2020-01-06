# frozen_string_literal: true

describe AuthorizeApiOperation do
  describe "#call" do
    subject(:authorize) { described_class.new(headers).call }
    let(:headers) { Hash["Authorization" => token] }
    let(:token) { JsonWebToken.encode(user_id: user.id) }
    let(:user) { build_stubbed :user }

    before do
      allow(User).to receive(:find_by).with(id: user.id).and_return(user)
    end

    it "returns user" do
      expect(subject.value!).to eq([:ok, user])
    end

    context "with invalid token" do
      let(:token) { "123" }

      it "returns error and payload" do
        expect(subject.failure).to eq [:unauthorized, "Invalid token"]
      end
    end

    context "without token" do
      let(:headers) { Hash[] }

      it "returns error and payload" do
        expect(subject.failure).to eq [:unauthorized, "Missing token"]
      end
    end

    context "without user" do
      let(:token) { JsonWebToken.encode(user_id: user.id.next) }

      before do
        allow(User).to receive(:find_by).and_call_original
      end

      it "returns error and payload" do
        expect(subject.failure).to eq [:unauthorized, "User doesn't exist"]
      end
    end
  end
end
