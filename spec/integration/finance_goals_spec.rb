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

      parameter name: :moneybox_id, type: :number, in: :path

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
end
