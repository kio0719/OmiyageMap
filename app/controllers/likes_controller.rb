class LikesController < ApplicationController
  before_action :post_params
  def create
    current_user.likes.create(post_id: params[:post_id])
  end

  def destroy
    Like.find_by(post_id: params[:post_id], user_id: current_user.id).destroy
  end

  def post_params
    @post = Post.find(params[:id])
  end
end
