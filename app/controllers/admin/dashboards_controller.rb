class Admin::DashboardsController < AdminController
  before_action :authenticate_user, {only: [:index]}
  layout 'admin/layouts/admin'

  def index
  end
end