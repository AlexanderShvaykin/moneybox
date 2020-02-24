# frozen_string_literal: true

RSpec.describe Api::PlanedExpensesController, :with_auth_user do
  let_it_be(:moneybox) { create :moneybox, user: user }
  let_it_be(:goal, reload: true) { create :finance_goal, moneybox: moneybox }

  describe "POST #create" do
    subject { post :create, params: params.merge(form_params), as: :json }

    let(:params) { Hash[finance_goal_id: goal.id] }
    let(:form_params) { Hash[name: :Milk, amount: 100] }

    it "creates new planed expenses" do
      expect { subject }.to change(PlanedExpense, :count).by(1)
        .and change(goal.planed_expenses, :count).by(1)
        .and change { goal.reload.payment_amount }.by(100)
    end

    context "with alien goal" do
      let_it_be(:goal, reload: true) { create :finance_goal }

      it "doesn't create new expenses" do
        expect { subject }.not_to change(PlanedExpense, :count)
      end
    end
  end

  describe "PATCH #update" do
    subject { post :update, params: params.merge(form_params), as: :json }

    let_it_be(:planed_expense, reload: true) do
      create :planed_expense, amount: 100, name: "Milk", goal: goal
    end
    let(:params) { Hash[id: planed_expense.id] }
    let(:form_params) { Hash[amount: 300] }

    before_all do
      goal.update(payment_amount: planed_expense.amount)
    end

    it "updates expense" do
      expect { subject }.to change { planed_expense.reload.amount }.to(300)
       .and change { goal.reload.payment_amount }.by(200)
    end
  end
end
