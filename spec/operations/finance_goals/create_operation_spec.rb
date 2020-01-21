# frozen_string_literal: true

describe FinanceGoals::CreateOperation do
  describe "#call" do
    subject { described_class.new(params).call(repo) }

    let(:monexbox) { instance_double(MoneyboxEntry, finance_goals: goals) }
    let(:record) { instance_double(FinanceGoal) }
    let(:repo) { class_double(MoneyboxEntry, find_by: monexbox, create!: record) }
    let(:goals) { class_double(FinanceGoal, create!: record) }
    let(:params) do
      {
          payment_amount: 100,
          income_amount: 100,
          started_at: Time.current.to_i,
          finished_at: 1.month.from_now.to_i
      }
    end

    it_behaves_like "calls find_operation"

    it "creates moneybox" do
      expect(goals).to receive(:create!).with(params)
      subject
    end

    context "with invalid params" do
      let(:params) do
        {
            payment_amount: 100,
            income_amount: 100,
            started_at: Time.current.to_i,
            finished_at: ""
        }
      end

      it "doesn't create moneybox" do
        expect(goals).not_to receive(:create!).with(params)
        subject
      end
    end
  end
end
