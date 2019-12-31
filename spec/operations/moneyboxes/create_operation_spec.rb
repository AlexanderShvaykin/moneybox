describe Moneyboxes::CreateOperation do
    describe "#call" do
    subject(:create_model) { described_class.new(params).call }

    let(:params) { Hash[name: "Foo"] }
    let(:model) { instance_double(MoneyboxEntry, save: true, errors: []) }

    before do
      allow(MoneyboxEntry).to receive(:new).with(params).and_return(model)
    end

    it "saves model" do
      expect(model).to receive(:save)
      create_model
    end

    it "returns created code and record" do
      expect(subject.value!).to eq [:created, model]
    end

    context "without name" do
      let(:params) { Hash[] }

      it "doesn't save model" do
        expect(model).not_to receive(:save)
        create_model
      end

      it "returns error and payload" do
        expect(subject.failure).to contain_exactly :bad_params, instance_of(Hash)
      end
    end

    context "with empty name" do
      let(:params) { Hash[name: ""] }

      it "doesn't save model" do
        expect(model).not_to receive(:save)
        create_model
      end

      it "returns error and payload" do
        expect(subject.failure).to contain_exactly :bad_params, instance_of(Hash)
      end
    end
  end
end
