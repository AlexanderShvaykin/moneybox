# frozen_string_literal: true

class FinanceGoalForm < ApplicationForm
  attributes :goal, :payment_amount, :income_amount
  attribute :started_at, :date
  attribute :finished_at, :date

  validates :started_at, :finished_at, :goal, presence: true
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
    return if finished_at.nil? || started_at.nil?

    errors.add(:finished_at) if finished_at < started_at
  end
end
