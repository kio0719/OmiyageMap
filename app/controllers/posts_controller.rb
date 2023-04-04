class PostsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_post, only: [:show,:edit,:update,:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to root_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :caption, :place, :image, :user_id)
  end
end
