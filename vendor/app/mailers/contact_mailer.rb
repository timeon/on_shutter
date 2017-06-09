class ContactMailer < ActionMailer::Base
  
  def setup(contact)
    @contact = contact
    @url  = contact_url(contact, :key=>contact.key)
  end
  
  def updated_contact(contact)
    setup(contact)
    
    if contact.emails
      mail(:host    => configatron.site_url,
           :to      => contact.emails,
           :from    => "<#{ActionMailer::Base.smtp_settings[:user_name]}>",
           :subject => "中区主恩堂2014通讯录更新 - Thank you for updating" )
    end       
  end

  def check_contact(contact)
    setup(contact)
    
    if contact.emails
      mail(:host    => configatron.site_url,
           :to      => contact.emails,
           :from    => "<#{ActionMailer::Base.smtp_settings[:user_name]}>",
           :subject => "中区主恩堂2014通讯录更新 - Please verify your contact" )
    end       
  end

end

