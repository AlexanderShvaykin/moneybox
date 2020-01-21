# frozen_string_literal: true

class FinanceGoalForm < ApplicationForm
  attributes :goal, :payment_amount, :income_amount, :started_at, :finished_at
  attribute :started_at, :unix_format_time
  attribute :finished_at, :unix_format_time

  validates :started_at, :finished_at, numericality: { greater_than_or_equal_to: 1 }
  validate :check_time_difference

  private

  def persist!
    goal.assign_attributes(
      payment_amount: payment_amount,
      income_amount: income_amount,
      started_at: started_at,
      finished_at: finished_at
    )

    goal.save!
  end

  def check_time_difference
    errors.add(:finished_at) if finished_at < started_at
  end
end
