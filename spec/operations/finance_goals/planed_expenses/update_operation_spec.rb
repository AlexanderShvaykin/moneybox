# frozen_string_literal: true

describe FinanceGoals::PlanedExpenses::UpdateOperation do
  describe "#call" do
    subject(:update) { described_class.new(params).call(repo) }

    let(:repo) { MockRepository.new(record: record) }
    let(:record) do
      build_stubbed :planed_expense, goal: goal, amount: 100, id: 2
    end
    let(:goal) { build_stubbed :finance_goal }
    let(:params) { Hash[name: "Foo", id: 2] }

    before do
      allow(goal).to receive(:save!).and_return(true)
      allow(record).to receive(:save!).and_return(true)
    end

    it_behaves_like "calls find_operation"
    it_behaves_like "return result" do
      let(:result) { [:ok, record] }
    end

    it "updates record" do
      expect(record).to receive(:assign_attributes).with(name: "Foo")
      update
    end

    it "finds record" do
      expect(repo).to receive(:find_by).with(id: 2)
      update
    end

    it "doesn't update goal" do
      expect(goal).not_to receive(:increment)
      update
    end

    context "with amount" do
      let(:params) { Hash[amount: 300] }

      it "updates record" do
        expect(record).to receive(:assign_attributes).with(amount: 300)
        update
      end

      it "updates goal" do
        expect(goal).to receive(:increment).with(:payment_amount, 200)
        update
      end

      it "save goal and expense" do
        expect(record).to receive(:save!)
        expect(goal).to receive(:save!)
        update
      end
    end
  end
end
