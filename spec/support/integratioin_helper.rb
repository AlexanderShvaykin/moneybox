# frozen_string_literal: true

module IntegrationHelper
  def response_401
    response 401, "Invalid credentials" do
      let(:Authorization) { "123" }
      schema "$ref" => "#/definitions/error_msg"

      run_test!
    end
  end

  def response_404(var_name = :id)
    response 404, "Invalid credentials" do
      let(var_name) { 0 }
      schema "$ref" => "#/definitions/error_msg"

      run_test!
    end
  end
end
