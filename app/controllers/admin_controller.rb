class AdminController < ApplicationController
  before_action :find_post

  def index 
  end

  def posts
    @posts = Post.all.includes(:user, :comments).paginate(page: params[:page], per_page: 5)
  end 

  def users
    @users = User.all.includes(:posts, :comments).paginate(page: params[:page], per_page: 5)
  end 

  def approve_post
    @post = Post.find_by(id: params[:id])
    @postebi.update(approved: true)
    mail = UsersMailer.approve_post(@post.user_id)
    mail.deliver_now
    redirect_to @post
  end

  def post_delete
    @post = Post.includes(:user, :comments).find(params[:id])
    @post.destroy
    flash[:notice] = "Post was successfully deleted"
    redirect_to admin_post_path
  end

  def user_delete
    @users = User.all.includes(:posts, :comments)
    @user = @users.find(params[:id])
    @user.destroy 
    flash[:notice] = "User was successfully deleted!"
    redirect_to admin_users_path
  end

  private
    def find_post 
      @postebi = Post.includes(:user, :comments).find_by(id: params[:id])
    end
end
