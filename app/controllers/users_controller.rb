class UsersController < ApplicationController
  before_action :set_user

  def profile
  end

  def profile_edit
  end

  def profile_update
    if @user.update(user_params)
      flash[:notice] = "プロフィールの情報が更新されました"
      redirect_to users_profile_path
    else
      flash[:warning] = "プロフィールの更新に失敗しました"
      render "profile_edit"
    end
  end

  def account
  end
  
  def account_edit
  end

  def account_update
    if @user.update(user_params)
      flash[:notice] = "アカウントの情報が更新されました。"
      redirect_to users_account_path
    else
      flash[:warning] = "アカウントの更新に失敗しました"
      render "account_edit"
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :introduction, :icon)
  end
end
