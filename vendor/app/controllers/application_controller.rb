# https://github.com/dannymcc/BaseApp2
# http://blog.bernatfarrero.com/in-place-editing-with-javascript-jquery-and-rails-3/
# https://github.com/bernat/best_in_place

class ApplicationController < ActionController::Base
  
#  before_filter :prepare_for_mobile
  before_filter :seen_user
  before_filter :save_return_params
  before_filter :save_referer_url
  before_filter :mailer_set_url_options
  before_filter :set_user
  before_filter :get_resource_info
  
  helper :all # include all helpers, all the time
  
  # Return the value for a given setting
  def s(identifier)
    Setting.get(identifier)
  end
  helper_method :s

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9fe6825f97cc334d88925fde5c4808a8'
  
  alias :logged_in? :user_signed_in?
  helper_method :logged_in?
  helper_method :admin?
  helper_method :coworker?
  helper_method :photo_enabled?

  def admin?
    current_user and current_user.admin?
  end

  def photo_enabled?
    configatron.contents.to_hash.keys.include?(:photo)    
  end
  
  def set_user  
    if @current_user == nil and session[:user_id] != nil
      @current_user ||= User.find_by_id(session[:user_id])
    end  
  end

  def authenticate_user!
    if !current_user
      flash[:error] = 'You need to sign in before accessing this page!'
      redirect_to signin_services_path
    end
  end  
    
  def ensure_admin
    if not logged_in? or not current_user.admin?
      flash[:error] = "Not Authorized !"
      redirect_back_or_default('/')
    end
  end

  def ensure_admin_or_owner
    if logged_in?
      if current_user.admin?
        authorized = true
      elsif params[:id]
        resource = eval(params[:controller].classify).find(params[:id].to_i)
        if resource.respond_to?(:user_id) and resource.user_id == current_user.id
          authorized = true
        elsif resource.respond_to?(:id) and resource == current_user
          authorized = true
        end
      elsif params[self.controller_name.singularize]
        if params[self.controller_name.singularize][:user_id].to_i == current_user.id
          authorized = true
        end
      end       
    end
      
    if !authorized
      flash[:error] = "Not Authorized."
      redirect_back_or_default(root_path)
    end

    return authorized
  end

  def coworker?
    current_user and current_user.coworker?
  end
  
  def ensure_admin_or_owner_or_coworker
    if logged_in?
      if admin? or coworker?  
        authorized = true
      elsif params[:id]
        # check if the owner of the resource is the current user
        resource = eval(params[:controller].classify).find(params[:id].to_i)
        if resource.respond_to?(:user_id) and resource.user_id == current_user.id
          authorized = true
        elsif resource.respond_to?(:id) and resource == current_user
          authorized = true
        end
      elsif params[self.controller_name.singularize]
        # check if the resource is the current user
        if params[self.controller_name.singularize][:user_id].to_i == current_user.id
          authorized = true
        end
      end       
    end

    # check if the key matches the key on the resource
    if !authorized and params[:key] and params[:id]
      resource = eval(params[:controller].classify).find(params[:id].to_i)
      if resource.respond_to?(:key) and resource.key == params[:key]
        authorized = true
      end  
    end
          
    if !authorized
      flash[:error] = "Not Authorized."
      redirect_back_or_default(root_path)
    end

    return authorized
  end


  layout :layout_by_resource  
  def layout_by_resource
    if devise_controller? or (params[:controller] = 'photos' and params[:action] == 'new')
      "application"
    else
      "application"
    end
  end
    
  def after_sign_in_path_for(resource)
    session[:return_url] || root_path
  end

  private

  def save_return_params
    session[:return_path] = params[:return_path]
    session[:anchor]      = params[:anchor]
    session[:tab]         = params[:tab]
    session[:page]        = params[:page]

    session[:return_params] = ""
    session[:return_params] += "&tab="  + params[:tab] if params[:tab] 
    session[:return_params] += "&page=" + params[:page] if params[:page] 
    session[:return_params] += "#"      + params[:anchor] if params[:anchor] 

    if params[:return_path]
      session[:return_url] = params[:return_path]
      session[:return_url] += "?tab="  + params[:tab] if params[:tab] 
      session[:return_url] += "&page=" + params[:page] if params[:page] 
      session[:return_url] += "#"      + params[:anchor] if params[:anchor] 
    end 
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  def seen_user
    if logged_in?
      current_user.seen = DateTime.now
      current_user.save
    end
  end

  # Redirect to the URI stored by the most recent store_location call or
  # to the passed default.  Set an appropriately modified
  #   after_filter :store_location, :only => [:index, :new, :show, :edit]
  # for any controller you want to be bounce-backable.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def save_referer_url
    if session[:referer_url_id] ==  nil
      referer_url = ReferrerUrl.find_or_create_by(url: request.referer ? request.referer[0..255] : nil)
      
      browser = Browser.new(:user_agent => request.user_agent)
      
      hit = referer_url.hits.build( :ip => request.remote_ip,
                                    :host => request.remote_host,
                                    :url => request.url,
                                    :browser_name     => browser.name,
                                    :browser_version  => browser.full_version,
                                    :browser_platform => browser.platform.to_s);
      hit.save
      session[:referer_url_id] = referer_url.id
    end
  end

  def get_resource_info
    @adding_post = false
    
    if configatron.contents.to_hash.keys.include?(params[:controller].singularize.to_sym)
      @post_name      = params[:controller].singularize
      @posts_name     = params[:controller]
      @post_id_name   = params[:controller].singularize + "_id"
      @post_class     = Kernel.const_get(params[:controller].singularize.camelize)
      @post_praise    = configatron.contents.send(@post_name).praise
      @new_post_name  = "new_" + params[:controller].singularize

      @response_name  = configatron.contents.send(@post_name).response_name
      @responses_name = configatron.contents.send(@post_name).response_name.pluralize
      @response_display_name  = configatron.contents.send(@post_name).response_display_name
      @responses_display_name = configatron.contents.send(@post_name).response_display_name.pluralize
      @response_praise= configatron.contents.send(@post_name).response_praise
      
      @current_content= @post_name
      
      if logged_in? 
        @favorite_posts = current_user.send("favorite_" + @posts_name)
      end
      
      if params[:action] == 'new'
        @adding_post = true
      end  
    elsif configatron.responses.to_hash.keys.include?(params[:controller].singularize.to_sym)
      @response_name      = params[:controller].singularize
      @responses_name     = params[:controller]
      @response_praise    = configatron.responses.send(@response_name).praise
      
      @response_id_name   = params[:controller].singularize + "_id"
      @response_class     = Kernel.const_get(params[:controller].singularize.capitalize)
      @new_response_name  = "new_" + params[:controller].singularize
      @current_content    = configatron.responses.send(@response_name).content
    elsif params[:controller] == "users"
      @current_content    = "users"        
    else
      @current_content    = configatron.main_content        
    end
  end

  def after_sign_in_path_for(resource)
    session[:return_to]    
  end

end
