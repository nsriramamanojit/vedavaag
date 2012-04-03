# Author: Chaitanya
#
#--------------------------------------
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :created_by_or_updated_by
  helper_method :current_user_session, :current_user
  before_filter { |c| Authorization.current_user = c.current_user }
  def created_by_or_updated_by
    if current_user
      @created_by = current_user.id
      @updated_by = current_user.id
      @created_name = current_user.name
      @updated_name = current_user.name
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    if current_user and current_user.status?
      return true
    elsif current_user and !current_user.status?
      store_location
      flash[:warning] = "Your account not yet approved."
      redirect_to new_user_session_url
      return false
    else
      store_location
      flash[:error] = "You must be logged in to access this page."
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to user_path(current_user)
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  protected

  def permission_denied
    flash[:error] = "Sorry, You have NO Permission to access the Content."
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to homes_path
  end

  def per_page
    if params[:per_page]
      @per_page = params[:per_page]
    else
      @per_page = 20
    end
  end

  def page
    if params[:page]
      @page = params[:page]
    else
      @page = 1
    end
  end
end
