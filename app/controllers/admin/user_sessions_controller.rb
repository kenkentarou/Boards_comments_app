class Admin::UserSessionsController < AdminController
  layout 'admin/layouts/admin_login'

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(admin_path, success: 'ログインしました')
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
