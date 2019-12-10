class Admin::AdminController < ApplicationController
  def authenticate_user
    redirect_to(root_path, warning: '権限がありません') if current_user.general?
  end
end