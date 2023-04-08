class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end
end
