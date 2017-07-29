class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    def after_sign_in_path_for(resource)
      "/signedinuserprofile"
    end
  
  # restrict certain pages to admin only  
  def authorize_admin
    redirect_to restricted_path unless current_user.admin
  end
end
