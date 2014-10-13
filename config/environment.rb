# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
StaffingApp::Application.initialize!

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address   => "smtp.4thsource.com",
  :port      => 587,
  :domain    => "4thsource.com",
  #:user_name => "mario.canto@4thsource.com",
  :user_name => "user@4thsource.com",
  :password  => "-123abc-",
  :openssl_verify_mode => 'none',
  :authentication       => "plain",
  :enable_starttls_auto => false,
}


 