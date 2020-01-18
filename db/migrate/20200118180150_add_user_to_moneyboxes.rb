# frozen_string_literal: true

class AddUserToMoneyboxes < ActiveRecord::Migration[6.0]
  def change
    add_column :moneybox_entries, :user_id, :integer
    add_foreign_key :moneybox_entries, :users, on_delete: :cascade
    add_index :moneybox_entries, :user_id
  end
end
