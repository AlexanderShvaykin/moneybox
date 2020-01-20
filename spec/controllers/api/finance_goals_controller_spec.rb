# frozen_string_literal: true

describe Api::FinanceGoalsController, :with_auth_user do
  let_it_be(:moneybox) { create :moneybox, user: user }
  let_it_be(:fin_goal) { create :finance_goal, moneybox: moneybox }

  describe "GET #index" do
    specify  do
      expect(get: "/api/moneyboxes/1/finance_goals")
          .to route_to(controller: "api/finance_goals", action: "index", moneybox_id: 1)
    end

    subject { get :index, params: { moneybox: moneybox } }

    it "returns goals" do
      expect(subject.body).to include_json(data: UnorderedArray(id: fin_goal.id.to_s))
    end
  end
end
