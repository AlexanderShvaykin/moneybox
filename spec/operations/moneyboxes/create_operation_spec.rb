# frozen_string_literal: true

describe Moneyboxes::CreateOperation do
  describe "#call" do
  subject(:create_model) { described_class.new(user: user, **params).call }

  let(:params) { Hash[name: "Foo"] }
  let(:model) { instance_double(MoneyboxEntry, errors: []) }
  let(:user) { instance_double(User, moneybox_entries: mock_repo) }
  let(:mock_repo) { class_double(MoneyboxEntry, create!: model) }

  it "saves model" do
    expect(mock_repo).to receive(:create!).with(params)
    create_model
  end

  it "returns created code and record" do
    expect(subject.value!).to eq [:created, model]
  end

  context "without name" do
    let(:params) { Hash[] }

    it "doesn't save model" do
      expect(mock_repo).not_to receive(:create!)
      create_model
    end

    it "returns error and payload" do
      expect(subject.failure).to contain_exactly :bad_request, instance_of(Array)
    end
  end

  context "with empty name" do
    let(:params) { Hash[name: ""] }

    it "doesn't save model" do
      expect(mock_repo).not_to receive(:create!)
      create_model
    end

    it "returns error and payload" do
      expect(subject.failure).to contain_exactly :bad_request, instance_of(Array)
    end
  end
end
end
