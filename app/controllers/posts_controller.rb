class PostsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

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
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to root_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :caption, :place, :image, :user_id)
  end
end
