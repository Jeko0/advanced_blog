class CommentsController < ApplicationController
  before_action :set_post
  decorates_assigned :comments, :comment


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user 

    if @comment.save 
      redirect_to post_path(@post), notice: "Comment was created"
    else
      redirect_to post_path(@post), alert: "comment can't be blank"
    end
  end

  def update
    @comment = Comment.find_by(id: params[:id])
   respond_to do |format|
    if @comment.update(comment_params)
      format.html { redirect_to post_url(@post), notice:"Comment has been update"}

    else
      format.html { redirect_to post_url(@post), alert:"Something went wrong"}
    end
   end
  end


  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: "comment deleted"
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
