describe Moneyboxes::DestroyOperation do
  describe "#call" do
    subject(:delete_record) { described_class.new(params).call }

    let(:params) { Hash[name: "Foo", id: id] }
    let(:record) { build_stubbed :moneybox }
    let(:id) { 1 }

    before do
      allow(MoneyboxEntry).to receive(:find_by).with(id: id).and_return(record)
    end

    it "delete record" do
      expect(record).to receive(:delete)
      delete_record
    end

    context "with not found" do
      before do
        allow(MoneyboxEntry).to receive(:find_by).with(id: id).and_return(nil)
      end

      it "returns not_found code and record" do
        expect(subject.failure).to contain_exactly :not_found, instance_of(Hash)
      end
    end

    context "with mock update" do
      before do
        allow(record).to receive(:delete).and_return(true)
      end

      it "returns ok code and record" do
        expect(subject.value!).to eq [:ok, ""]
      end

      context "with fail update" do
        before do
          allow(record).to receive(:delete).and_return(false)
        end

        it "returns error code and payload" do
          expect(subject.failure).to eq [:unprocessable_entity, record.errors]
        end
      end
    end
  end
end
