class AdminController < ApplicationController
  before_action :find_post

  def index 
  end

  def posts
    @posts = Post.all.includes(:user, :comments)
  end
  
  def users
    @users = User.all
  end
  
  def approve_post
    @postebi.update(approved: true)
    redirect_to admin_post_path
  end

  def post_author 
    @user = User.find_by(id: params[:id])
    @q = @user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).where(approved: true).paginate(page: params[:page], per_page: 2)
  end

  def delete
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post was successfully deleted"
    redirect_to admin_post_path
  end

  private
    def find_post 
      @postebi = Post.includes(:user, :comments).find_by(id: params[:id])
    end
end
