class Admin::UserSessionsController < Admin::AdminController
  layout 'admin/layouts/admin_login'
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :authenticate_user, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(admin_root_path, success: 'ログインしました')
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(:root, success: 'ログアウトしました')
  end
end
