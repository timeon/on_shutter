Rails.application.routes.draw do

  resources :docs do
    member do
       get :download
    end
  end
    
  resources :searches
  resources :contacts do
    member do
       get :verify
       get :check
    end
    collection do
      get :check_all
      get :list
      get :photo
      get :print
      get :print_photo
    end        
  end
  resources :albums

  # Omniauth pure
  match "/signin" => "services#signin", via: :get
  match "/signout" => "services#signout", via: :get

  match '/auth/:service/callback' => 'services#create', via: :all
  match '/auth/failure' => 'services#failure', via: :all

  resources :services, :only => [:index, :create, :destroy] do
    collection do
      get 'signin'
      get 'signout'
      get 'signup'
      post 'newaccount'
      get 'failure'
    end
  end

  devise_for :users, :controllers => { :sessions => "user_sessions" },
                     :path_names => { :sign_in => 'login', 
                                      :sign_out => 'logout',  
                                      :registration => 'register' }

  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :profiles

  resources :users do
  #resources :u, :as => :users, :controller => :users do
     member do
       get :edit_password
       get :collect_photos_to_album 
       put :update_password
       get :edit_email
       put :update_email
       get :edit_avatar
       get :style 
       put :update_avatar
       put :star
    end
  end

  resources :hits
  resources :urls, :as => :referrer_urls, :controller => :referrer_urls

  resources :comments

  resources :photos do
  #resources :p, :as => :photos, :controller => :photos do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :critiques do
  #resources :c, :as => :critiques, :controller => :critiques do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :questions do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :answers do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :articles do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :reviews do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :testimonies do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :echos do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end
  
  resources :prayer_requests do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end

  resources :prayers do
     member do
       put :vote_up
       put :vote_down
       put :star
       put :comment
    end
  end
  
  resources :announcements
  resources :dashboard
  
  # RESTful rewrites
  
  # Administration
  namespace :admin do 
    root :to => 'dashboard#index'
    resources :settings 
    match '/settings/update_settings' => 'settings#update_settings', via: :get
    
    resources :announcements
    resources :commits
    match '/users/search' => 'users#search', via: :get
    resources :users do 
      member do 
        put :suspend
        put :unsuspend
        put :activate
        delete :purge
        put :reset_password
        get :set_user_login
        get :set_user_email        
      end
      collection do
        get :pending
        get :active
        get :suspended
        get :deleted
      end
    end
  end

  match 'cc', :controller => :contacts, :action => :index, via: :get
  root        :controller => configatron.main_content.pluralize, :action => :index
  match ':action', :controller => 'pages', via: :get
end
