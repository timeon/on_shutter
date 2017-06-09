module PostsController
  def index
    page = params[:page] || 1
    page =1 if page.to_i < 1
    per_page = @post_class.per_page

    @tab = params[:tab] || "recent"

    if params[:user] != nil
      user = User.find(params[:user])
      if user and @tab == user.display_name + "'s favorite"
        @posts = user.send("favorite_#{@posts_name}").order("vote_count DESC").paginate(:page=>page, :per_page=>per_page)
      elsif user
        @posts = user.send(@posts_name).order("vote_count DESC").paginate(:page=>page, :per_page=>per_page)
      end
    elsif params[:keyword] != nil
debugger      
      @posts = @post_class.where('title LIKE ? or body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%").paginate(:page=>page, :per_page=>per_page)
      @tab = "matching"
    elsif params[:no_response] != nil
      @posts = @post_class.paginate_by_sql ["SELECT * FROM #{@posts_name} LEFT JOIN #{@responses_name} ON #{@posts_name}.id = #{@responses_name}.#{@post_id_name} WHERE #{@responses_name}.#{@post_id_name} IS NULL ORDER BY #{@posts_name}.vote_count DESC"], :page=>page, :per_page=>per_page
    elsif params[:album] != nil
      @album = Album.find(params[:album])
      @posts = @album.send(@posts_name).order("vote_count DESC").paginate(:page=>page, :per_page=>per_page)
    elsif ["my", "favorite"].include?(@tab) and current_user == nil
      redirect_to new_user_session_path + "?return_to=/#{@posts_name}" + session[:return_params]
    else
      case @tab
        when "recent"
          @posts = @post_class.order("created_at DESC").paginate(:page=>page, :per_page=>per_page)
        when "popular"
          @posts = @post_class.order("vote_count DESC").paginate(:page=>page, :per_page=>per_page)
        when "my"
          @posts = current_user.send(@posts_name).order("vote_count DESC").paginate(:page=>page, :per_page=>per_page)
        when "favorite"
          @posts = current_user.send("favorite_#{@posts_name}").order("vote_count DESC").paginate(:page=>page, :per_page=>per_page)
        else
          @posts = @post_class.order("vote_count DESC").paginate(:page=>page, :per_page=>per_page)
        end
    end
    
    respond_to do |format|
      format.html { render 'posts/index' }
      format.xml  { render :xml => @posts }
    end
  end  
  
  def show
    find_post
    
    @post.view_count += 1
    @post.save
    
    @response_count = @post.send(@responses_name).count
    
    # show new response form only if this usre has not responded yet
    if !current_user or @post.send(@responses_name).where(user_id: current_user.id).take
      @response = @post.send(@responses_name).build(:user => current_user)
    end
    
    respond_to do |format|
      format.html {render 'posts/show', :locals => {:post => @post}}
      format.xml  {render :xml => @post}
    end
  end

  def new
    if current_user == nil
      redirect_to new_user_session_path and return
    else
      @post = current_user.send(@posts_name).new
    end

    respond_to do |format|
      format.html {render 'posts/new', :locals => {:post => @post}}
    end    
  end

  def create
    @post = @post_class.new(user_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Thank you for your post.') }
        format.xml  { render :xml => @post }
      else
        format.html { redirect_to :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    find_post
    respond_to do |format|
      format.html {render 'posts/edit', :locals => {:post => @post}}
    end 
  end
  
  def update
    find_post

    respond_to do |format|
      if @post.update_attributes(user_params)
        format.html { redirect_to @post}
        format.js   { render :partial => '/posts/info', :locals => {:post => @post}}
        format.json { head :ok }
      else
        format.html { redirect_to 'edit'}
        format.js   { render :partial => '/posts/info', :locals => {:post => @post}}
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    find_post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to( "/" + @posts_name) }
      format.xml  { head :ok }
    end
  end

  def vote(direction)
    @post = @post_class.find(params[:id])

    # CAUSION: clear_votes needs to be after voted_which_way?
    if current_user != nil
      if current_user.voted_which_way?(@post, direction)
        # double vote in the same direction cancels the votes
        current_user.clear_votes(@post)
      else
        # replace existing vote if any
        current_user.clear_votes(@post)
        
        # record vote
        current_user.vote(@post, { :direction => direction})
      end
    end

    respond_to do |format|
      if current_user
        format.js   {render :partial => 'posts/vote', :locals => {:post => @post}}
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

  def star
    @post = @post_class.find(params[:id])

    if @favorite_posts.include?(@post)
      @favorite_posts.delete(@post)
    else
      @favorite_posts << @post
    end

    respond_to do |format|
      format.js   {render :partial => 'posts/vote', :locals => {:post => @post}}
    end
  end
  
  def comment
    @post = @post_class.find(params[:id])
    comment = @post.comments.create(:title => nil, :comment => params[:comment], :user_id=> current_user.id)
    
    respond_to do |format|
      format.js   { render :partial => 'comments/show', :locals => {:comment=> comment}}
    end
  end
  
  private
  
  def user_params
    params.require(@post_name).permit(:user_id, :image_url, :image, :album_id, :title, :body, :new_album)
  end    

  def find_post
    @post = @post_class.find_by_slug(params[:id])
    if ! @post
      @post = @post_class.find(params[:id])
    end
  end  
  
end
