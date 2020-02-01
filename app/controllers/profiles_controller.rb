class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]
  def show; end

  def edit;
  end

  def update
    if @user.update(user_update_params)
      redirect_to(profile_path, success: 'プロフィールを更新しました')
    else
      flash.now[:danger] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  private

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :user_image_cache)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
