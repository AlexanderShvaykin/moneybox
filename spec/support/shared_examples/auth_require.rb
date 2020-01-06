RSpec.shared_examples "auth require" do
  it "return unauthorized error" do
    expect(subject.status).to eq(401)
  end
end
