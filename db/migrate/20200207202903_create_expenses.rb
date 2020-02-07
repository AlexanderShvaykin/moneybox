# frozen_string_literal: true

class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :amount
      t.references :planed_expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
