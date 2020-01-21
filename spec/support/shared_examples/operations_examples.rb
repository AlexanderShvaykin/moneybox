# frozen_string_literal: true

RSpec.shared_examples "calls find_operation" do
  it "calls operation" do
    expect(FindOperation).to receive(:new).and_call_original
    subject
  end
end
