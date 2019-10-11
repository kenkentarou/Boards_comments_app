class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインが必要です'
  end
end
