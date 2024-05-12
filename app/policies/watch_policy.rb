class WatchPolicy < ApplicationPolicy
  attr_reader :user, :watch

  def initialize(user, watch)
    @user = user
    @watch = watch
  end

  def update?
    user.present? && watch.user == user
  end

  def destroy?
    user.present? && watch.user == user
  end
end