require 'will_paginate/array'

class SearchesController < ApplicationController

  def index
    page = params[:page] || 1
    page =1 if page.to_i < 1
    per_page = Question.per_page

    @tab = "matches for #{params[:keyword]}"
    @posts_name = "All"

    if params[:keyword] != nil
      photos = Photo.find(:all, :conditions => ['title LIKE ? or body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).paginate(:page=>page, :per_page=>per_page)
      questions = Question.find(:all, :conditions => ['title LIKE ? or body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).paginate(:page=>page, :per_page=>per_page)
      articles = Article.find(:all, :conditions => ['title LIKE ? or body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).paginate(:page=>page, :per_page=>per_page)

      photos = Photo.all
      questions = Question.all
      articles = Article.all
      
      @posts = photos
      @posts <<  questions
      @posts << articles
    debugger
      
      @posts = @posts.paginate 
    end
    debugger
    respond_to do |format|
      format.html { render 'posts/index' }
      format.xml  { render :xml => @posts }
    end
  end  
  
end
