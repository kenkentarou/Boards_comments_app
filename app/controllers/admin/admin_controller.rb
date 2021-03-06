class Admin::AdminController < ApplicationController
  layout 'admin/layouts/admin'
  before_action :require_login
  before_action :authenticate_user

  private

  def authenticate_user
    redirect_to(root_path, warning: '権限がありません') unless current_user.admin?
  end

  def not_authenticated
    redirect_to(root_path, warning: 'ログインしてください')
  end
end
