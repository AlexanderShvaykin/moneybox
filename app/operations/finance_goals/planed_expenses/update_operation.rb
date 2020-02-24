# frozen_string_literal: true

class FinanceGoals::PlanedExpenses::UpdateOperation < FinanceGoals::PlanedExpenses::CreateOperation
  schema do
    optional(:amount).value(:integer)
    optional(:name).filled(:string)
  end

  def call(repo)
    expense = yield(::FindOperation.new(id: params[:id]).call(repo)).last
    values = yield validate_schema
    yield update_expense(expense, values)

    Success([:ok, expense])
  end

  private

  def update_expense(expense, values)
    goal = expense.goal
    expense.assign_attributes(values)

    if expense.amount_changed?
      goal.increment(:payment_amount, expense.amount_change.reduce(:-) * -1)
    end

    ApplicationRecord.transaction do
      expense.save!
      goal.save!
    end
    Success(expense)
  end
end
