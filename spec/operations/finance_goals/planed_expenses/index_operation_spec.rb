# frozen_string_literal: true

describe FinanceGoals::PlanedExpenses::IndexOperation do
  describe "#call" do
    subject { described_class.new(params).call(repo) }

    let(:repo) { class_double(FinanceGoal, find_by: goal) }
    let(:goal) { instance_double(FinanceGoal, planed_expenses: planed_expenses) }
    let(:planed_expenses) { class_double(FinanceGoal, order: []) }
    let(:params) { Hash[finance_goal_id: 1] }

    it "returns planed_expenses order by id" do
      expect(planed_expenses).to receive(:order).with(:id)
      expect(subject.value!).to contain_exactly :ok, []
    end

    context "with goal not found" do
      let(:repo) { class_double(FinanceGoal, find_by: nil) }

      it "returns not_found code and record" do
        expect(subject.failure).to contain_exactly :not_found, instance_of(Array)
      end
    end
  end
end
