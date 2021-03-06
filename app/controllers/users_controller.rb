class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.includes(:boards).order(created_at: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(login_path, success: 'ユーザー登録が完了しました')
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
