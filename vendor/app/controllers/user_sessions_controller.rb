class UserSessionsController < Devise::SessionsController

  before_filter :save_return_to, :only => [:new]

  def save_return_to
    session[:return_to] = params[:return_to]
  end

end
