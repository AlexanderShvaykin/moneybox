# frozen_string_literal: true

class FinanceGoals::UpdateOperation < FinanceGoals::CreateOperation
  def call(repo)
    find_result = yield ::FindOperation.new(id: params[:id]).call(repo)
    values = yield validate_schema
    record = yield save_record(find_result.last, values)

    Success([:created, record])
  end

  private

  def save_record(goal, values)
    form = FinanceGoalForm.new(goal: goal, **values)
    if form.save
      Success(form.goal)
    else
      Failure([:unprocessable_entity, form.serialized_errors])
    end
  end
end
