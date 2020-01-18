# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

class ApplicationOperation
  include Dry::Monads[:result, :do]

  attr_reader :params

  def initialize(params)
    @params = params.with_indifferent_access.freeze
  end

  def self.schema(**options, &block)
    define_method(:validate_schema) do
      result = Dry::Schema.Params(**options, &block).call(params)

      if result.success?
        Success(result.to_h)
      else
        Failure([:bad_request, map_schema_errors(result.errors)])
      end
    end

    def map_schema_errors(errors)
      errors.to_h.map { |k, v| { title: "#{k}: #{v.join(' ,')}" } }
    end
  end
end
