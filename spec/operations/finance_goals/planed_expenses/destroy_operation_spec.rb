# frozen_string_literal: true

describe FinanceGoals::PlanedExpenses::DestroyOperation do
  describe "#call" do
    subject(:destroy) { described_class.new(params).call(repo) }

    let(:params) { Hash[id: 2] }
    let(:repo) { MockRepository.new(record: record) }
    let(:record) { build_stubbed :planed_expense, goal: goal, amount: 100 }
    let(:goal) { build_stubbed :finance_goal }

    before do
      allow(record).to receive(:destroy!).and_return(record)
      allow(goal).to receive(:save!).and_return(record)
    end

    it_behaves_like "calls find_operation"
    it_behaves_like "return result" do
      let(:result) { [:ok, record] }
    end

    it "decrement goal" do
      expect(goal).to receive(:decrement).with(:payment_amount, 100)
      expect(goal).to receive(:save!)
      destroy
    end

    it "destroy record" do
      expect(record).to receive(:destroy!)
      destroy
    end
  end
end
