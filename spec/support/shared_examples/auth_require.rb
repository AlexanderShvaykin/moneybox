# frozen_string_literal: true

RSpec.shared_examples "auth require" do
  let(:auth_token) { "" }

  it "return unauthorized error" do
    expect(subject.status).to eq(401)
  end
end
