class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ profile ]
  before_action :set_user, only: %i[ profile_edit profile_update account ]
  before_action :ensure_normal_user, only: %i[profile_edit profile_update]

  def profile
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user).page(params[:page]).per(10)
    @comment_posts = Post.includes(:comments).where( comments: { user_id: @user }).page(params[:page]).per(10)
    @like_posts = Post.includes(:likes).where( likes: { user_id: @user }).page(params[:page]).per(10)
  end

  def profile_edit
  end

  def profile_update
    if @user.update(user_params)
      flash[:notice] = "プロフィールの情報が更新されました"
      redirect_to users_profile_path(current_user)
    else
      flash[:alert] = "プロフィールの更新に失敗しました"
      render "profile_edit"
    end
  end

  def account
  end

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :name, :introduction, :icon)
  end
end
