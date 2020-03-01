# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

class ApplicationOperation
  include Dry::Monads[:result, :do]

  attr_reader :params, :user

  # @param [User] user
  # @param [Hash] params Controller params
  def initialize(user: nil, **params)
    @user   = user
    @params = params.with_indifferent_access.freeze
  end

  # define_method validate_schema, and define Dry::Schema.Params and calls check schema
  # validate_schema => Monads::Result
  # @example
  #   ...
  #   schema do
  #     required(:name).filled(:string)
  #   end
  #
  #   def call
  #     values = yield validate_schema
  #   end
  # @param [Proc] block
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
  end

  # @abstract
  # @return [Dry::Monads::Result]
  def call; raise NotImplementedError; end

  private

  def map_schema_errors(errors)
    errors.to_h.values.flatten.map { |v| { title: v } }
  end
end
