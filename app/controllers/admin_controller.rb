class AdminController < ActionController::Base
  include Admin::SessionsHelper

  class FatalError < RuntimeError
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :verify_login
  rescue_from FatalError, with: :fatal_error

  @current_user = nil

  private

    def verify_login
      session[:user] ||= 0
      session[:secret] ||= ""
      if session[:user] > 0 and brute_force_counter < 10
        user = Admin::User.find_by_id_and_user_secret(session[:user], session[:secret])
        if user
          @current_user = user
        else
          brute_force_add
          session[:user] = 0
          session[:secret] = ""
        end
      end
    end

    def fatal_error(exception)
      @msg = exception
      render "admin/error"
    end

    def require_login
      redirect_to new_admin_session_path, alert: "You are not logged in." unless @current_user
    end
end
