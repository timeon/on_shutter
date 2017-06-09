class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :ensure_admin_or_owner, :only => [:edit, :update, :destroy]

  before_filter :find_user, 
    :only => [:profile, 
              :edit_password,   :update_password, 
              :edit_email,      :update_email ]
  
  def index
    @users = User.all(:order => :reputation_count)
    @users.delete_if {|u| u.login == "admin" }
  end

  def show
    @user = User.find(params[:id])
    if @user
      @user.view_count += 1
      @user.save
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def style
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end  
  
  def collect_photos_to_album
    @user = User.find(params[:id])
    @user.collect_photos_to_album
    redirect_to(@user.albums[0])
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def star
    @user = User.find(params[:id])

    if current_user.favorite_users.include?(@user)
      current_user.favorite_users.delete(@user)
    else
      current_user.favorite_users << @user
    end
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.js   {render :partial => 'star', :locals => {:photo => @photo}}
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.js       
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end  

  def troubleshooting
    # Render troubleshooting.html.erb
  end

  def clueless
    # These users are beyond our automated help...
  end

  
  def edit_password
    if ! @user.not_using_openid?
      flash[:notice] = "You cannot update your password. You are using OpenID!"
      redirect_to :back
    end
    
    # render edit_password.html.erb
  end
  
  def update_password    
    if !@user.not_using_openid?
      flash[:notice] = "You cannot update your password. You are using OpenID!"
      redirect_to :back
    end
    if @user.update_with_password(params[:user])
      redirect_to root_path, :notice => "Password updated!"
    else
      @user.errors.each do |name ,msg| 
        flash[:error] = name.to_s.titleize + " " + msg
      end
      render :edit_password        
    end
 
  end
  
  def edit_email
    if ! @user.not_using_openid?
      flash[:notice] = "You cannot update your email address. You are using OpenID!"
      redirect_to :back
    end
    
    # render edit_email.html.erb
  end
  
  def update_email
    if ! @user.not_using_openid?
      flash[:notice] = "You cannot update your email address. You are using OpenID!"
      redirect_to :back
    end
    
    if current_user == @user
      if @user.update_attributes(:email => params[:email])
        flash[:notice] = "Your email address has been updated."
        redirect_to profile_url(@user)
      else
        flash[:error] = "Your email address could not be updated."
        redirect_to edit_email_user_url(@user)
      end
    else

      flash[:error] = "You cannot update another user's email address!"
      redirect_to edit_email_user_url(@user)
    end
  end  
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    current_user.delete!
    
    logout_killing_session!
    
    flash[:notice] = "Your account has been removed."
    redirect_back_or_default(root_path)
  end  
  
  protected

  def find_user
    @user = User.find(params[:id])
  end

  def create_new_user(attributes)
    @user = User.new(attributes)
    @user.referrer_url_id = session[:referer_url_id]
    @user.display_name = @user.login
    if @user && @user.valid?
      if @user.not_using_openid?
        @user.register!
      else
        @user.register_openid!
      end
    end
    
    if @user.errors.empty?
      successful_creation(@user)
    else
      failed_creation
    end
  end
  
end