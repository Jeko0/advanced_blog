class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  class Scope < Scope
    def resolve
      raise Pundit::NotDefinedError, "Cannot scope NilClass"
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

  def approve_post?
    user_is_admin
  end

  def show?
    if post.member_only
      require_user_is_member_or_!
    else
      true
    end
  end

  private 

  def admin_or_author
    user.admin? || user == post.user
  end

  def user_is_admin 
    user.admin?
  end

  def admin_or_user 
    user.admin? || user.user?
  end
end