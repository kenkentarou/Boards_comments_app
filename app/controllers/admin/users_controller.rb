class Admin::UsersController < Admin::AdminController
  before_action :require_login
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.includes(:boards).order(created_at: :desc).page(params[:page])
  end

  def show;
  end

  def edit;
  end

  def update
    if @user.update(user_update_params)
      redirect_to(admin_user_path(params[:id]), success: 'ユーザー情報を更新しました')
    else
      flash.now[:danger] = 'ユーザー情報を更新できませんでした'
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to(admin_users_path, success: 'ユーザーを削除しました')
  end

  private

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :user_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
