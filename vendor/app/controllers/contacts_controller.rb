class ContactsController < ApplicationController
  
  #before_filter :ensure_admin_or_owner, :only => [:show, :create, :edit, :update, :destroy]
  before_filter :ensure_admin_or_owner_or_coworker, :only => [:show, :create, :edit, :update, :destroy]
  before_filter :ensure_admin, :only => [:verify_all, :verify]
  
  def get_all
    if admin? or coworker?
      
      if !params[:disabled] || params[:disabled] == false
         disabled = false;
      else
         disabled = true;
      end
      
      per_page = params[:per_page] || 10
      
      if params[:page]
        @contacts = Contact.where(:disabled => disabled).paginate(:page => params[:page], :per_page=>per_page)
      else
        @contacts = Contact.where(:disabled => disabled)
      end  
        @contacts = @contacts.order(:adult_1_last_name)
    elsif logged_in?
      match_contacts_to_user
      @contacts = current_user.contacts
    else
      @contacts = Array.new
    end      
  end
  
  # GET /contacts
  # GET /contacts.xml
  def index
    get_all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  def list
    get_all
  end
  
  def photo
    get_all
  end
  
  def print
    get_all
  end
  
  def print_photo
    get_all
  end
  
  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  def check_all
    get_all
    
    @contacts.each do |contact|
      if (contact.adult_1_email or contact.adult_2_email) and !contact.verified   
        #ContactMailer.check_contact(contact).deliver
        #logger.info "mail #{contact.adult_1_email} for verification"
        contact.shadow
      end
    end
          
    redirect_to contacts_path
  end

  def verify
    @contact = Contact.find(params[:id])
    
    if @contact
      @contact.verified = true
    end
    
    respond_to do |format|
      if @contact.save
        format.html { redirect_to contact_path(@contact, :key=>@contact.key)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  def check
    @contact = Contact.find(params[:id])
    
    if @contact.adult_1_email or @contact.adult_2_email  
      ContactMailer.check_contact(@contact).deliver
    end
          
    redirect_to contact_path(@contact, :key=>@contact.key)
  end
  
  
  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    if logged_in?
      @contact = Contact.new
      @contact.user = current_user
      @contact.city = "San Diego"
      @contact.state = "CA"
      @contact.zip = "9212"
    end
        
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contact_path(@contact, :key=>@contact.key)}
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])
    @contact.shadow
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contact_path(@contact, :key=>@contact.key)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
  
  def match_contacts_to_user
    contacts  = Contact.where(adult_1_email: current_user.email)
    contacts += Contact.where(adult_2_email: current_user.email)
    contacts.each do |contact|
      contact.user = current_user
      contact.save 
    end    
  end
 
  private

    def contact_params
        params.require(:contact).permit(:user_id, :photo, :photo_number, :street_no_and_name , :city , :state , :zip , :home_phone , :adult_1_first_name, :adult_1_last_name , :adult_1_chinese_name , :adult_1_email , :adult_1_phone , :adult_1_phone_ext , :adult_2_first_name, :adult_2_last_name , :adult_2_chinese_name , :adult_2_email , :adult_2_phone , :adult_2_phone_ext , :child_1_first_name, :child_1_last_name, :child_1_chinese_name, :child_2_first_name, :child_2_last_name, :child_2_chinese_name, :child_3_first_name, :child_3_last_name, :child_3_chinese_name, :child_4_first_name, :child_4_last_name, :child_4_chinese_name, :child_5_first_name, :child_5_last_name, :child_5_chinese_name, :verified, :disabled, :note, :one_more_year);
    end

end
