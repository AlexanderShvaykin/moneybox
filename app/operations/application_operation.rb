# frozen_string_literal: true
require 'dry/monads'
require 'dry/monads/do'

class ApplicationOperation
  include Dry::Monads[:result, :do]

  attr_reader :params

  def initialize(params)
    @params = params.with_indifferent_access.freeze
  end

  def self.schema(**options, &block)
    define_method(:validate_schema) do
      Dry::Schema.Params(**options, &block).call(params)
    end
  end

  private

  def validate
    result = validate_schema
    if result.success?
      Success(result.to_h)
    else
      Failure([:bad_params, result.errors.to_h])
    end
  end
end
