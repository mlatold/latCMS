class Admin::DashboardController < AdminController
  def index
    unless @current_user
      redirect_to new_admin_session_path
    end
  end
end