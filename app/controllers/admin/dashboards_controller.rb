class Admin::DashboardsController < Admin::BaseController
  before_action :authenticate_user
  layout 'admin/layouts/admin'

  def index;
  end
end
