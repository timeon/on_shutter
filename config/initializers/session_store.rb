# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_OnShutters_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# OnShutters::Application.config.session_store :active_record_store

# OnShutters::Application.config.session_store :active_record_store   # >rake db:sessions:create  >rake db:migrate
OnShutters::Application.config.session_store :cookie_store

OnShutters::Application.config.session = {
  :key          => '_omniauthpure_session',     # name of cookie that stores the data
  :domain       => nil,                         # you can share between subdomains here: '.communityguides.eu'
  :expire_after => 1.month,                     # expire cookie
  :secure       => false,                       # fore https if true
  :httponly     => true,                        # a measure against XSS attacks, prevent client side scripts from accessing the cookie
  
  :secret      => '4918468ca694ac858cb4698b7fd154e109dd0b9fa0c074e464fb9bbbb94077a7f64e68062eb792ac6482a5dfe740ef4af1f6ca3c6e9c0f85ba604763ac85fa3a'
}
