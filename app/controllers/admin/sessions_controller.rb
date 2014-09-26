class Admin::SessionsController < AdminController
  include Admin::SessionsHelper

  def new
  end

  def create
    user = Admin::User.find_by(email: params[:admin_session][:email].downcase)
    if brute_force_counter >= 10
      flash.now[:error] = "You have made too many login attempts, try again in 10 minutes."
      render 'new'
    elsif user && user.authenticate(params[:session][:password])
      flash.now[:done] = "Logged in successfully!"
      #sign_in user
      #redirect_back_or user
    else
      brute_attempts = 11 - brute_force_add # Adds additional brute force attempt and returns the total
      flash.now[:warning] = "Invalid credentials. You have " + brute_attempts.to_s + " " + "attempt".pluralize(brute_attempts) + " left."
      render 'new'
    end
  end

  def destroy
    flash.now[:done] = "Logged out successfully!"
    redirect_to root_url
  end
end
