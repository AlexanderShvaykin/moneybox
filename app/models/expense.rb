class Expense < ApplicationRecord
  belongs_to :planed_expense, optional: true
end
