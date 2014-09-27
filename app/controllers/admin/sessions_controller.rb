class Admin::SessionsController < AdminController
  include Admin::SessionsHelper

  def new
  end

  def create
    user = Admin::User.find_by(email: params[:admin_session][:email].downcase)
    if brute_force_counter >= 10
      flash.now[:alert] = "You have made too many login attempts, try again in 10 minutes."
      render 'new'
    elsif user && user.authenticate(params[:admin_session][:password])
      @current_user = user
      session[:user] = user.id
      session[:secret] = user.user_secret
      redirect_to admin_root_path, notice: "Logged in successfully!"
      #sign_in user
      #redirect_back_or user
    else
      brute_attempts = 11 - brute_force_add # Adds additional brute force attempt and returns the total
      flash.now[:alert] = "Invalid credentials. You have " + brute_attempts.to_s + " " + "attempt".pluralize(brute_attempts) + " left."
      render 'new'
    end
  end

  def destroy
    session[:user] = 0
    session[:secret] = ""
    redirect_to new_admin_session_path, notice: "Logged out successfully!"
  end
end
