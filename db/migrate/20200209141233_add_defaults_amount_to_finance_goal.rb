# frozen_string_literal: true

class AddDefaultsAmountToFinanceGoal < ActiveRecord::Migration[6.0]
  def change
    change_column_default :finance_goals, :payment_amount, 0
    change_column_default :finance_goals, :income_amount, 0
  end
end
