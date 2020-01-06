# frozen_string_literal: true

describe Moneyboxes::UpdateOperation do
  describe "#call" do
    subject(:update_model) { described_class.new(params).call }

    let(:params) { Hash[name: "Foo", id: id] }
    let(:record) { build_stubbed :moneybox }
    let(:id) { 1 }

    before do
      allow(MoneyboxEntry).to receive(:find_by).with(id: id).and_return(record)
    end

    it "update record" do
      expect(record).to receive(:update).with(name: "Foo")
      update_model
    end

    context "with mock update" do
      before do
        allow(record).to receive(:update).and_return(true)
      end

      it "returns ok code and record" do
        expect(subject.value!).to eq [:ok, record]
      end

      context "with fail update" do
        before do
          allow(record).to receive(:update).and_return(false)
        end

        it "returns ok code and record" do
          expect(subject.failure).to eq [:unprocessable_entity, record.errors]
        end
      end
    end

    context "with not found" do
      before do
        allow(MoneyboxEntry).to receive(:find_by).with(id: id).and_return(nil)
      end

      it "returns not_found code and record" do
        expect(subject.failure).to contain_exactly :not_found, instance_of(Hash)
      end
    end

    context "with invalid params" do
      let(:params) { Hash[name: "", id: id] }

      it "returns error and payload" do
        expect(subject.failure).to contain_exactly :bad_request, instance_of(Hash)
      end
    end
  end
end
