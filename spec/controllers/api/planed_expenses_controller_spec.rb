# frozen_string_literal: true

RSpec.describe Api::PlanedExpensesController, :with_auth_user do
  describe "POST #create" do
    subject { post :create, params: params.merge(form_params), as: :json }

    let_it_be(:moneybox) { create :moneybox, user: user }
    let_it_be(:goal, reload: true) { create :finance_goal, moneybox: moneybox }
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
end
