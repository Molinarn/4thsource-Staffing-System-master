# Be sure to restart your server when you modify this file.

StaffingApp::Application.config.session_store :cookie_store, :key => '_staffing_token', :expire_after => -355.minutes
																						#330 minutes are 5.5 hours and its means that
																						#our cookie will expire in 30 minutes because the diference
																						#in the server timezone(GMT)  and our time zone(UMT-6)

#AppName::Application.config.session_store :active_record_store, :key => 'your_cookie', :expire_after => 2.hours


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# StaffingApp::Application.config.session_store :active_record_store
