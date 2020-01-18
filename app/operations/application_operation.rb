# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

class ApplicationOperation
  include Dry::Monads[:result, :do]

  attr_reader :params

  def initialize(params)
    @params = params.with_indifferent_access.freeze
  end

  def self.schema(&block)
    define_method(:validate_schema) do
      result = Dry::Schema.Params do
        config.messages.backend = :i18n
        instance_eval(&block)
      end.call(params)

      if result.success?
        Success(result.to_h)
      else
        Failure([:bad_request, map_schema_errors(result.errors)])
      end
    end

    def map_schema_errors(errors)
      errors.to_h.values.flatten.map { |v| { title: v } }
    end
  end
end
