# frozen_string_literal: true

class UnixFormatTimeType < ActiveModel::Type::Value
  def cast(value)
    Time.zone.at(value)
  end
end
