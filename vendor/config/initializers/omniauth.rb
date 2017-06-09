  Rails.application.config.middleware.use OmniAuth::Builder do
    # ALWAYS RESTART YOUR SERVER IF YOU MAKE CHANGES TO THESE SETTINGS!

    # you need a store for OpenID; (if you deploy on heroku you need Filesystem.new('./tmp') instead of Filesystem.new('/tmp'))
    require 'openid/store/filesystem'

    # load certificates
    require "openid/fetchers"
    OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"

    # providers with id/secret, you need to sign up for their services (see below) and enter the parameters here
    provider :facebook, configatron.facebook.appid, configatron.facebook.apikey, {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
    provider :twitter, '1YDTn2yRHh9XGyT5MOHzjQ', 'LmuP012T2YBJLNTpgZKvVbrWd7dKcvtCGfq8xk0VJU'
    #provider :github, 'CLIENT ID', 'SECRET'

    # generic openid
    provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'

    # dedicated openid
    provider :openid, :store => OpenID::Store::Filesystem.new("#{Rails.root}/tmp"), :name => 'google',   :identifier => 'https://www.google.com/accounts/o8/id'
    # provider :google_apps, OpenID::Store::Filesystem.new('./tmp'), :name => 'google_apps'
    # /auth/google_apps; you can bypass the prompt for the domain with /auth/google_apps?domain=somedomain.com

    provider :openid, :store => OpenID::Store::Filesystem.new("#{Rails.root}/tmp"), :name => 'yahoo',    :identifier => 'yahoo.com' 
    provider :openid, :store => OpenID::Store::Filesystem.new("#{Rails.root}/tmp"), :name => 'aol',      :identifier => 'openid.aol.com'
    provider :openid, :store => OpenID::Store::Filesystem.new("#{Rails.root}/tmp"), :name => 'myopenid', :identifier => 'myopenid.com'

    # Sign-up urls for Facebook, Twitter, and Github
    # https://developers.facebook.com/setup
    # https://github.com/account/applications/new
    # https://developer.twitter.com/apps/new
  end 
