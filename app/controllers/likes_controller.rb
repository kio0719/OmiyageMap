class LikesController < ApplicationController
  before_action :post_params
  def create
    Like.create(post_id: params[:id], user_id: current_user.id)
  end

  def destroy
    Like.find_by(post_id: params[:id], user_id: current_user.id).destroy
  end

  def post_params
    @post = Post.find(params[:id])
  end
end
