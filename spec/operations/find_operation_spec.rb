describe FindOperation do
  describe "#call" do
    subject(:find_record) { described_class.new({}).call(repo) }

    let(:record) { double(:record) }
    let(:repo) { double(:Repo, find_by: record) }

    it "returns ok and record" do
      expect(subject.value!).to eq [:ok, record]
    end

    context "with record is nil" do
      let(:record) { nil }

      it "returns error and payload" do
        expect(subject.failure).to contain_exactly :not_found, instance_of(Hash)
      end
    end
  end
end
