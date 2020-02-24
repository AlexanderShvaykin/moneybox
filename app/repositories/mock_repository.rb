# frozen_string_literal: true

class MockRepository
  attr_reader :relation, :record

  def initialize(record: nil, relation: [])
    @record = record
    @relation = relation
  end

  def find_by(*)
    record
  end

  def where(*)
    self
  end

  def method_missing(m)
    relation.public_send(m)
  end
end
