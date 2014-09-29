class Admin::SessionsController < AdminController
  include Admin::SessionsHelper
  before_filter :must_be_logged_out, only: [:new, :create]

  def new
  end

  def create
    user = Admin::User.find_by(email: params[:admin_session][:email].downcase)
    # Brute force protection
    if brute_force_counter >= 10
      flash.now[:alert] = "You have made too many login attempts, try again in 10 minutes."
      render 'new'
    # Successful login
    elsif user && user.authenticate(params[:admin_session][:password])
      Admin::User.where(email: params[:admin_session][:email].downcase).update_all(last_login: DateTime.now)
      @current_user = user
      session[:user] = user.id
      session[:secret] = user.user_secret
      redirect_to admin_root_path, notice: "Logged in successfully!"
    # Wrong login
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

  private
    def must_be_logged_out
      redirect_to admin_root_path, notice: "You are already logged in." if @current_user
    end
end
