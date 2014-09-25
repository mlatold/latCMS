class Admin::SessionsController < AdminController
  def new
  end

  def create
    user = Admin::User.find_by(email: params[:admin_session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:done] = "Logged in successfully!"
      #sign_in user
      #redirect_back_or user
    else
      flash.now[:error] = "Invalid credentials"
      render 'new'
    end
  end

  def destroy
    flash.now[:done] = "Logged out successfully!"
    redirect_to root_url
  end
end
