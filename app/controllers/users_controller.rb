class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ profile ]
  before_action :set_user, only: %i[ profile_edit profile_update account ]
  before_action :ensure_normal_user, only: %i[profile_edit profile_update]

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).includes([images_attachments: :blob], [user: [icon_attachment: :blob]], :likes).per(25)
    @comment_posts = @user.comment_posts.page(params[:page]).includes([images_attachments: :blob], [user: [icon_attachment: :blob]], :likes, :comments).per(25)
    @like_posts = @user.like_posts.page(params[:page]).includes([images_attachments: :blob], [user: [icon_attachment: :blob]], :likes).per(25)
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
