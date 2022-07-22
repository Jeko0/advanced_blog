class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  class Scope < Scope
    def resolve
      unless user == nil 
        scope.all if user.admin?
        scope.where(approved: true) if user.vip?
        scope.where(approved: true, vip_only: false) if user.user?
      end
    end
  end

  def initialize(user, post)
    @user, @post = user, post
  end

  def create?
    admin_or_user
  end

  def update?
    admin_or_author
  end

  def destroy?
   admin_or_author
  end

  def new?
    admin_or_user
  end

  def show?
    true
  end

  private 

    def admin_or_author
      user.admin? || user == post.user
    end

    def user_is_admin 
      user.admin?
    end

    def admin_or_user
      user.admin? || user.user? || user.vip?
    end
end