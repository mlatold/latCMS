class Admin::DashboardController < AdminController
  def index
    redirect_to new_admin_session_path
  end
end