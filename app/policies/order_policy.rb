class OrderPolicy < ApplicationPolicy
  def show?
    user.admin? || record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
