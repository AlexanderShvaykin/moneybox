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

    it "returns Success" do
      expect(subject).to be_a(Dry::Monads::Result::Success)
    end

    context "without name" do
      let(:params) { Hash[] }

      it "doesn't save model" do
        expect(model).not_to receive(:save)
        create_model
      end

      it "returns Failure" do
        expect(subject).to be_a(Dry::Monads::Result::Failure)
      end
    end

    context "with empty name" do
      let(:params) { Hash[name: ""] }

      it "doesn't save model" do
        expect(model).not_to receive(:save)
        create_model
      end

      it "returns Failure" do
        expect(subject).to be_a(Dry::Monads::Result::Failure)
      end
    end
  end
end
