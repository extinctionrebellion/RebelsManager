class RebelsIndexPresenter
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def rebels_count
    user.local_group&.rebels&.count || Rebel.all.count
  end
end
