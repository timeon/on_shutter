require 'will_paginate/array'
require "i18n"
require "open-uri"
require 'uri'
require 'nokogiri'

class PhotosController < ApplicationController
  include PostsController
  
  before_filter :logged_in?, :except => [:index, :show]
  before_filter :ensure_admin_or_owner, :only => [:create, :edit, :update, :destroy]
  before_filter :ensure_album, :only => [:new, :create]
  
  def ensure_album
    if params[:new_album] and params[:new_album][:title] and params[:new_album][:title].length > 0 
      album = current_user.albums.build(:title => params[:new_album][:title])
      album.save
      params[@post_name][:album_id] = album.id
    elsif logged_in? and photo_enabled? and current_user.albums.count == 0
      album = current_user.albums.new(:title => "#{current_user.name}'s best")
      album.save
    elsif current_user
      album = current_user.albums[0]
    else
      return false  
    end
    
    if params[@post_name] and !params[@post_name][:album_id]
      params[@post_name][:album_id] = album.id
    end
  end  

  def create
    url = params[:photo][:image_url]
    if url and url.include? "onebigphoto"
      Photo.process_obp(url)
      redirect_to photos_path  and return
    elsif url and url.include? "flickr"
      Photo.process_flickr(url)
      redirect_to photos_path  and return
    elsif url and url.include? "500px"
      Photo.process_500px(url)
      redirect_to photos_path  and return
    else      
      @photo = Photo.new(user_params)
  
      respond_to do |format|
        if @photo.save
          format.html { redirect_to(@photo, :notice => 'Thank you for your post.') }
          format.xml  { render :xml => @photo }
        else
          format.html { redirect_to :action => "new" }
          format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
end
