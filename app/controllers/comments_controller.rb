class CommentsController < ApplicationController

  before_filter :logged_in?, :except => [:index, :show]
  
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.js   { render :partial => 'comments/show', :locals => {:comment => @comment}}
    end
    
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.js   { render :partial => 'comments/show', :locals => {:comment => @comment}}
        format.json { head :ok }
      else
        format.js   { render :partial => 'comments/show', :locals => {:comment => @comment}}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end    
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.js   { render 'comments/destroy'}
    end
  end
end
