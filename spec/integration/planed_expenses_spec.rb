# frozen_string_literal: true

require "swagger_helper"

describe "Planed expenses API", :with_api_user do
  path "/api/finance_goals/{goal_id}/planed_expenses" do
    let_it_be(:moneybox) { create :moneybox, user: user }
    let_it_be(:goal) { create :finance_goal, moneybox: moneybox }
    let_it_be(:planed_expense) { create :planed_expense, goal: goal }
    let(:goal_id) { goal.id }

    get "Get list of expenses" do
      tags "Planed Expenses"
      produces "application/json"
      security [ api_key: [] ]

      parameter name: :goal_id, type: :number, in: :path

      response 200, "Returns list" do
        schema type: :object, required: %i[data], properties: {
            data: { type: :array, items: { "$ref" => "#/definitions/planed_expense" } }
        }

        run_test!

        it "returns collection" do
          expect(JSON.parse(response.body)["data"].size).to eq(1)
        end
      end

      response_401
      response_404 :goal_id
    end
  end
end
