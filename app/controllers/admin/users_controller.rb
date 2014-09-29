class Admin::UsersController < AdminController
  before_filter :require_login

  def index
    @users = Admin::User.all
  end

  def destroy
    if params[:id].to_i == 1
      raise FatalError, "You are not allowed to delete the root user."
    end
    Admin::User.find(params[:id]).destroy
    redirect_to admin_users_path, notice: "User deleted."
  end
end
