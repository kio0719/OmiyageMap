class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:q].blank?
      params[:q] = { sorts: 'created_at desc'}
    end
      @q = Post.ransack(params[:q])
      @results = @q.result.page(params[:page]).per(10)
      @count = @results.count
  end
end
