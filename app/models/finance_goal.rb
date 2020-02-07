# frozen_string_literal: true

class FinanceGoal < ApplicationRecord
  belongs_to :moneybox, class_name: "MoneyboxEntry", foreign_key: "moneybox_entry_id"
  has_many :planed_expenses
end
