class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:notice] = "コメントの投稿に成功しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "コメントの投稿に失敗しました"
      @comments = @post.comments.order(created_at: :desc)
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash[:notice] = "コメントを削除しました"
    @post = Post.find(params[:post_id])
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
