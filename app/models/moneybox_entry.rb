# frozen_string_literal: true

class MoneyboxEntry < ApplicationRecord
  belongs_to :user
  has_many :finance_goal
end
