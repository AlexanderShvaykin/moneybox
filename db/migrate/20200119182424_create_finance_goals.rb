# frozen_string_literal: true

class CreateFinanceGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :finance_goals do |t|
      t.integer :payment_amount
      t.integer :income_amount
      t.datetime :started_at, null: false
      t.datetime :finished_at, null: false
      t.references :moneybox_entry, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
