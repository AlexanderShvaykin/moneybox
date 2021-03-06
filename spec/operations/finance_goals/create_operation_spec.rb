# frozen_string_literal: true

describe FinanceGoals::CreateOperation do
  describe "#call" do
    subject { described_class.new(params).call(repo) }

    let(:repo) { class_double(MoneyboxEntry, find_by: monexbox, create!: record) }
    let(:monexbox) { instance_double(MoneyboxEntry, finance_goals: goals) }
    let(:goals) { double(build: record) }
    let(:record) { instance_double(FinanceGoal) }
    let(:form) { instance_double(FinanceGoalForm, save: true, goal: record) }
    let(:started_at) { "2015-01-01" }
    let(:finished_at) { "2015-02-01" }
    let(:params) do
      {
          payment_amount: 100,
          income_amount: 100,
          started_at: started_at,
          finished_at: finished_at
      }
    end

    before do
      allow(FinanceGoalForm).to receive(:new).with(
        goal: record, payment_amount: 100, income_amount: 100,
        started_at: Date.parse(started_at), finished_at: Date.parse(finished_at)
      ).and_return(form)
    end

    it_behaves_like "calls find_operation"

    it "creates moneybox" do
      expect(form).to receive(:save)
      subject
    end

    context "with invalid params" do
      let(:params) do
        {
            payment_amount: 100,
            income_amount: 100,
            started_at: "2015-01-01",
            finished_at: ""
        }
      end

      it "doesn't create moneybox" do
        expect(form).not_to receive(:save)
        subject
      end
    end
  end
end
