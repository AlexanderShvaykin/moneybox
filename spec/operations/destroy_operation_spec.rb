# frozen_string_literal: true

describe DestroyOperation do
  describe "#call" do
    subject(:delete_record) { described_class.new(params).call(mock_repo) }

    let(:params) { Hash[name: "Foo", id: id] }
    let(:record) { build_stubbed :moneybox }
    let(:id) { 1 }
    let(:mock_repo) { class_double(MoneyboxEntry, find_by: record) }

    before do
      allow(mock_repo).to receive(:find_by).with(id: id).and_return(record)
    end

    it "delete record" do
      expect(record).to receive(:destroy!)
      delete_record
    end

    context "with not found" do
      before do
        allow(mock_repo).to receive(:find_by).with(id: id).and_return(nil)
      end

      it "returns not_found code and record" do
        expect(subject.failure).to contain_exactly :not_found, instance_of(Array)
      end
    end

    context "with mock update" do
      before do
        allow(record).to receive(:destroy!).and_return(true)
      end

      it "returns ok code and record" do
        expect(subject.value!).to eq [:ok, ""]
      end
    end
  end
end
