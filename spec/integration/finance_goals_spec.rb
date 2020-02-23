# frozen_string_literal: true

require "swagger_helper"

describe "Finance Goals API", :with_api_user do
  let_it_be(:moneybox) { create :moneybox, user: user }
  let_it_be(:fin_goal) { create :finance_goal, moneybox: moneybox }
  let(:moneybox_id) { moneybox.id }

  path "/api/moneyboxes/{moneybox_id}/finance_goals" do
    get "Get list of goals" do
      tags "goals"
      produces "application/json"
      security [ api_key: [] ]

      parameter name: :moneybox_id, type: :integer, in: :path

      response 200, "Returns list" do
        schema type: :object, required: %i[data], properties: {
            data: { type: :array, items: { "$ref" => "#/definitions/finance_goal" } }
        }

        run_test!

        it "returns collection" do
          expect(JSON.parse(response.body)["data"].size).to eq(1)
        end
      end

      response_401
      response_404 :moneybox_id
    end
  end

  path "/api/finance_goals/{id}" do
    let(:id) { fin_goal.id }

    get "Get goal" do
      tags "goals"
      produces "application/json"
      security [ api_key: [] ]

      parameter name: :id, type: :integer, in: :path

      response 200, "Returns goal info" do
        schema type: :object, required: %i[data], properties: {
          data: { "$ref" => "#/definitions/finance_goal" }
        }

        run_test!

        it "returns goal" do
          expect(JSON.parse(response.body)["data"]["id"]).to eq(fin_goal.id.to_s)
        end
      end

      response_401
      response_404
    end
  end
end
