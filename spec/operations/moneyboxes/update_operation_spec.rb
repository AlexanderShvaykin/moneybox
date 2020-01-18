# frozen_string_literal: true

describe Moneyboxes::UpdateOperation do
  describe "#call" do
    subject(:update_model) { described_class.new(user: user, **params).call }

    let(:params) { Hash[name: "Foo", id: id] }
    let(:record) { build_stubbed :moneybox }
    let(:id) { 1 }
    let(:user) { instance_double(User, moneybox_entries: mock_repo) }
    let(:mock_repo) { class_double(MoneyboxEntry, find_by: record) }

    before do
      allow(mock_repo).to receive(:find_by).with(id: id).and_return(record)
    end

    it "update record" do
      expect(record).to receive(:update!).with(name: "Foo")
      update_model
    end

    context "with mock update" do
      before do
        allow(record).to receive(:update!).and_return(true)
      end

      it "returns ok code and record" do
        expect(subject.value!).to eq [:ok, record]
      end
    end

    context "with not found" do
      before do
        allow(mock_repo).to receive(:find_by).with(id: id).and_return(nil)
      end

      it "returns not_found code and record" do
        expect(subject.failure).to contain_exactly :not_found, instance_of(Array)
      end
    end

    context "with invalid params" do
      let(:params) { Hash[name: "", id: id] }

      it "returns error and payload" do
        expect(subject.failure).to contain_exactly :bad_request, instance_of(Array)
      end
    end
  end
end
