class Admin::AdminController < ApplicationController
  before_action :authenticate_user
  before_action :require_login

  private

  def authenticate_user
    redirect_to(root_path, warning: '権限がありません') if current_user.general?
  end

  def not_authenticated
    redirect_to(root_path, warning: 'ログインしてください')
  end
end
