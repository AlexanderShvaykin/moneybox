# frozen_string_literal: true

RSpec.shared_examples "calls find_operation" do
  it "calls operation" do
    expect(FindOperation).to receive(:new).and_call_original
    subject
  end
end

RSpec.shared_examples "return result" do
  it "returns result" do
    expect(subject.value!).to eq result
  end
end
