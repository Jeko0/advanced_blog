class HomeController < ApplicationController
  decorates_assigned :user
  def index
    @posts = Post.all
  end

  def profile
    @user = User.find_by(id: params[:id])
  end
  
end
