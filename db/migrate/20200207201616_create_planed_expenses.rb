# frozen_string_literal: true

class CreatePlanedExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :planed_expenses do |t|
      t.string :name
      t.integer :amount
      t.references :finance_goal, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
