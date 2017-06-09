class ProfilesController < ApplicationController
  before_filter :find_profile
  before_filter :check_owner_access, :only => [:edit, :update]
  
  def update    
    unless @profile.nil?
      @profile.update_attributes(params[:profile])
      flash[:notice] = "Your profile has been succesfully updated."
      redirect_to profile_url(@profile.user)
    else
      render :edit
    end
  end
  
  protected

  def find_profile
    begin
      @user = User.find(params[:id])
    rescue
      @user = nil
    end
    @profile = @user.nil? ? nil : @user.profile
  end    
  
  def check_owner_access
    if not logged_in? or current_user != @user
      false
    else
      true
    end
  end
end
