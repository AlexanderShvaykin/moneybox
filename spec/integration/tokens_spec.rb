require 'swagger_helper'

describe "Tokens API" do
  let_it_be(:user) { create :user, secret: "123" }
  let(:params) do
    {
        email: user.email,
        password: "123"
    }
  end
  path "/tokens" do
    let_it_be(:goal) { create :finance_goal }
    let(:goal_id) { goal.id }

    post "Get list of expenses" do
      tags 'Planed Expenses'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
              email: { type: :string, example: "test@test.org" },
              password: { type: :string, example: "qwerty" }
          },
          required: %i[email password]
      }

      response 200, "Returns token" do
        schema type: :object, properties: {
            token: { type: :string, example: "some:token:jwt" }
        }

        run_test!
      end
    end
  end
end
