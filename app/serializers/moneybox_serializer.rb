# frozen_string_literal: true

class MoneyboxSerializer < ApplicationSerializer
  attributes :balance, :name

  has_many :finance_goals, lazy_load_data: true, links: {
      related: -> (object) {
        url_helpers.api_moneybox_finance_goals_url(moneybox_id: object.id)
      }
  }
end
