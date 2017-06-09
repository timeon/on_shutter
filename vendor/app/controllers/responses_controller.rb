module ResponsesController
  def create
    @response = @response_class.new(user_params)

    respond_to do |format|
      if @response.save
        format.js   { render :partial => 'responses/show', :locals => {:response => @response}}
      else
        format.js   { render '/responses/create'}
      end
    end
  end

  def update
    @response = @response_class.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(user_params)
        format.js   { render :partial => 'responses/show', :locals => {:response => @response}}
      else
        format.js
      end
    end
  end

  def destroy
    @response = @response_class.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.js   { render '/responses/destroy'}
    end
  end

  def vote(direction)
    @response = @response_class.find(params[:id])

    # CAUSION: clear_votes needs to be after voted_which_way?
    if current_user != nil
      if current_user.voted_which_way?(@response, direction)
        # double vote in the same direction cancels the votes
        current_user.clear_votes(@response)
      else
        # replace existing vote if any
        current_user.clear_votes(@response)
        # record vote
        current_user.vote(@response, { :direction => direction})
      end
    end

    respond_to do |format|
      if current_user and @response.update_attributes(params[@response_name])
        format.js   { render :partial => 'responses/vote', :locals => {:response => @response}}
      else
        format.js 
      end
    end
  end

  def vote_up
    vote(:up)
  end

  def vote_down
    vote(:down)
  end
  
  def comment
    @response = @response_class.find(params[:id])
    comment = @response.comments.create(:title => nil, :comment => params[:comment], :user=> current_user)
    
    respond_to do |format|
      format.js   { render :partial => 'comments/show', :locals => {:comment=> comment}}
    end
  end
  
  private
  
  def user_params
    params.require(@response_name).permit(:user_id, :photo_id, :body)
  end    
end
