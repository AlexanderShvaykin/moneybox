# frozen_string_literal: true

class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModelAttributes

  def self.attributes(*attrs)
    attrs.each { |name| attribute(name) }
  end

  def save
    return false unless valid?

    ApplicationRecord.transaction { persist! }
    true
  end

  def serialized_errors
    errors.full_messages.map { |msg| Hash[title: msg] }
  end

  private

  def persist!
    raise NotImplementedError, "Method #{self.class.name}#persist! must be defined"
  end
end
