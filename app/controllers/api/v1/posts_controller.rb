class Api::V1::PostsController < ApiController 
  before_action :set_post

  def show 
    render json: {
      id: @post.id,
      title: @post.title,
      body: @post.body  
    }
  end

  private 
  
    def set_post
      @post = Post.find(params[:id])
    end
end