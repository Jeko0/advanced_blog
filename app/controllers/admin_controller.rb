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
    redirect_to admin_posts_path
  end

  def delete
    @post = Post.includes(:user, :comments).find(params[:id])
    @post.destroy
    flash[:notice] = "Post was successfully deleted"
    redirect_to admin_post_path
  end

  private
    def find_post 
      @postebi = Post.includes(:user, :comments).find_by(id: params[:id])
    end
end
