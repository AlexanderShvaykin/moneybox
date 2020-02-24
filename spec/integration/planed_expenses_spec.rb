# frozen_string_literal: true

require "swagger_helper"

describe "Planed expenses API", :with_api_user do
  let_it_be(:moneybox) { create :moneybox, user: user }
  let_it_be(:goal) { create :finance_goal, moneybox: moneybox }
  let_it_be(:planed_expense) { create :planed_expense, goal: goal }

  path "/api/finance_goals/{goal_id}/planed_expenses" do
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

    post "Add new expenses" do
      let(:params) { Hash[name: "Mouse", amount: 10] }
      tags "Planed Expenses"
      consumes "application/json"
      produces "application/json"
      security [ api_key: [] ]

      parameter name: :goal_id, type: :number, in: :path
      parameter name: :params, in: :body, required: true, schema: {
          type: :object,
          properties: {
              name: { type: :string, example: "Milk" },
              amount: { type: :number, example: 100 }
          },
          required: %i[name amount]
      }

      response 201, "Returns new expense" do
        schema type: :object, required: %i[data], properties: {
            data: { "$ref" => "#/definitions/planed_expense" }
        }

        run_test!
      end

      response_401
      response_404 :goal_id
      response_400 :params, {}
    end
  end

  path "/api/planed_expenses/{id}" do
    patch "Update expense" do
      let(:params) { Hash[amount: 100] }
      let(:id) { planed_expense.id }

      tags "Planed Expenses"
      consumes "application/json"
      produces "application/json"
      security [ api_key: [] ]

      parameter name: :id, type: :number, in: :path
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: "Milk" },
          amount: { type: :number, example: 100 }
        }
      }

      response 200, "Returns expense" do
        schema type: :object, required: %i[data], properties: {
          data: { "$ref" => "#/definitions/planed_expense" }
        }

        run_test!
      end

      response_401
      response_404
      response_400 :params, { amount: "super bike" }
    end
  end
end
