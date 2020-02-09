class MoneyboxEntryRepository
  attr_reader :user, :relation

  def initialize(user, relation = MoneyboxEntry)
    @user = user
    @relation = relation
  end

  def find_by(id:)
    relation.where(id: id, user: user).first
  end
end
