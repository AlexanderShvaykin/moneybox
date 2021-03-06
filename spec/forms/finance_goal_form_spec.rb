# frozen_string_literal: true

describe FinanceGoalForm do
  let(:params) do
    {
        payment_amount: 100,
        income_amount: 100,
        started_at: Time.current,
        finished_at: 1.month.from_now
    }
  end

  describe "#save" do
    subject(:save_goal) { described_class.new(goal: record, **params).save }


    let_it_be(:moneybox) { create :moneybox }
    let(:record) { moneybox.finance_goals.build }

    it "creates FinanceGoal" do
      expect { subject }.to change(FinanceGoal, :count).by(1)
    end

    context "with goal" do
      let_it_be(:goal, reload: true) { create :finance_goal, moneybox: moneybox }
      let(:record) { goal }

      it "updates goal" do
        expect { subject }.to change { goal.reload.payment_amount }.to(100)
      end
    end
  end

  describe "validation" do
    subject { described_class.new(goal: record, **params) }

    let(:record) { instance_double(FinanceGoal) }

    specify { is_expected.to be_valid }

    context "with invalid finished_at" do
      let(:params) do
        {
            payment_amount: 100,
            income_amount: 100,
            started_at: Time.current,
            finished_at: ""
        }
      end

      specify { is_expected.not_to be_valid }
    end

    context "when finished_at greater_than started_at" do
      let(:params) do
        {
            payment_amount: 100,
            income_amount: 100,
            started_at: 2.days.ago,
            finished_at: 3.days.ago
        }
      end

      specify { is_expected.not_to be_valid }
    end
  end
end
