# frozen_string_literal: true

class CreateMoneyboxEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :moneybox_entries do |t|
      t.column :name, :string, null: false, limit: 100
      t.column :balance, :integer, null: false, default: 0

      t.timestamps
    end
  end
end
