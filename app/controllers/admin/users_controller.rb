class Admin::UsersController < AdminController
  before_filter :require_login

  def index
    @users = Admin::User.all
  end

  def edit
    if params[:id].to_i == 1 and @current_user.id != 1
      raise FatalError, "You are not allowed to edit the root user."
    end

    @user = Admin::User.find(params[:id])
  end

  def update
    @user = Admin::User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "User updated."
    else
      render 'edit'
    end
  end

  def destroy
    if params[:id].to_i == 1
      raise FatalError, "You are not allowed to delete the root user."
    end
    Admin::User.find(params[:id]).destroy
    redirect_to admin_users_path, notice: "User deleted."
  end

  private
    def user_params
      puts params
      params.require(:admin_user).permit(:email, :password, :password_confirmation)
    end
end
