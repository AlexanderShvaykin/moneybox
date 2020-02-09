class FinanceGoalRepository
  attr_reader :user, :relation

  def initialize(user, relation = FinanceGoal)
    @user = user
    @relation = relation
  end

  def find_by(id:)
    relation.where(moneybox: user.moneybox_entries).find_by(id: id)
  end
end
