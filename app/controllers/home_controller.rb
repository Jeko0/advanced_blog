class HomeController < ApplicationController
  def index
    @posts = Post.all
  end

  def profile
    @user = User.find_by(id: params[:id])
  end
  
end
