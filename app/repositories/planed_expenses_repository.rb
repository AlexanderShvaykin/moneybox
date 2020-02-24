class PlanedExpensesRepository
  attr_reader :relation, :user

  def initialize(user, relation = PlanedExpense)
    @user = user
    @relation = relation
  end

  def find_by(id:)
    relation.find_by(id: id)
  end
end
