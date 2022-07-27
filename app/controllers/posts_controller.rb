class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :logged_in?, except: :index
  before_action :require_authorize_post!, only: %i[ show edit update destroy ]

  decorates_assigned :posts, :post
  
  def index
    @q = Post.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @posts = @q.result(distinct: true).where(approved: true).paginate(page: params[:page], per_page: 2)
  end

  def show
    @comments = @post.comments.decorate
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post

    @post.update(vip_only: true) if post_params[:vip_only]

    @post.update(approved: true ) if @post.user.role == "admin"

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    flash[:notice] = "Post has been submitted And admin will take a look at it" unless current_user.role = "admin"
  end

  def update    
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
        format.html { redirect_to root_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def require_authorize_post!
      authorize @post
    end

    def post_params
      params.require(:post).permit(:title, :body, :user_id, :vip_only)
    end
end

