# frozen_string_literal: true

describe Api::FinanceGoalsController, :with_auth_user do
  let_it_be(:moneybox) { create :moneybox, user: user }
  let_it_be(:fin_goal) { create :finance_goal, moneybox: moneybox }
  let(:moneybox_id) { moneybox.id }

  describe "GET #index" do
    specify  do
      expect(get: "/api/moneyboxes/1/finance_goals")
          .to route_to(controller: "api/finance_goals", action: "index", moneybox_id: "1")
    end

    subject { get :index, params: { moneybox_id: moneybox_id } }

    it "returns goals" do
      expect(subject.body).to include_json(data: UnorderedArray(id: fin_goal.id.to_s))
    end

    context "with bad moneybox.id" do
      let(:moneybox_id) { 0 }

      it "returns 404" do
        expect(subject.code).to eq "404"
      end
    end
  end

  describe "POST #create" do
    specify  do
      expect(post: "/api/moneyboxes/1/finance_goals")
          .to route_to(controller: "api/finance_goals", action: "create", moneybox_id: "1")
    end

    subject { post :create, params: { moneybox_id: moneybox_id, **params }, as: :json }

    let(:params) do
      {
          payment_amount: 100,
          income_amount: 100,
          started_at: Time.current.iso8601,
          finished_at: 1.month.from_now.iso8601
      }
    end

    it "creates new goal" do
      expect { subject }.to change(moneybox.finance_goals, :count)
    end

    context "with bad moneybox.id" do
      let(:moneybox_id) { 0 }

      it "returns 404" do
        expect(subject.code).to eq "404"
      end
    end

    context "with invalid params value" do
      let(:params) do
        {
            payment_amount: 100,
            income_amount: 100,
            started_at: 2.month.from_now.iso8601,
            finished_at: 1.month.from_now.iso8601
        }
      end

      it "returns 422" do
        expect(subject.code).to eq "422"
      end
    end
  end

  describe "PATCH #update" do
    subject { patch :update, params: { id: finance_goal.id, **form_params }, as: :json }

    let_it_be(:moneybox) { create :moneybox, user: user }
    let_it_be(:finance_goal, reload: true) { create :finance_goal, moneybox: moneybox }
    let(:form_params) do
      {
          income_amount: 100,
          payment_amount: nil,
          started_at: Time.current.iso8601,
          finished_at: 1.month.from_now.iso8601
      }
    end

    specify  do
      expect(patch: "/api/finance_goals/1")
          .to route_to(controller: "api/finance_goals", action: "update", id: "1")
    end

    it "updates goal" do
      expect { subject }.to change { finance_goal.reload.income_amount }.to(100)
    end

    it "returns goal" do
      expect(subject.body).to include_json(data: { id: finance_goal.id.to_s })
    end
  end

  describe "PATCH #destroy" do
    subject { delete :destroy, params: { id: id } }

    let_it_be(:moneybox) { create :moneybox, user: user }
    let_it_be(:finance_goal) { create :finance_goal, moneybox: moneybox }
    let(:id) { finance_goal.id }

    specify  do
      expect(delete: "/api/finance_goals/1")
          .to route_to(controller: "api/finance_goals", action: "destroy", id: "1")
    end

    it "destroys goal" do
      expect { subject }.to change(FinanceGoal, :count).by(-1)
    end

    context "with other goal" do
      let_it_be(:other_goal) { create :finance_goal }
      let(:id) { other_goal.id }

      it "doesn't destroy goal" do
        expect { subject }.not_to change(FinanceGoal, :count)
      end
    end
  end
end
