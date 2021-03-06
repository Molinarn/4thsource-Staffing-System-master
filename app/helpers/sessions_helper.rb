module SessionsHelper
  USER = 0
  ADMIN = 1
  SUPERADMIN = 2

  require 'net/pop'

  def isSuperAdmin
    deny_access unless role == SessionsHelper::SUPERADMIN
  end

  def authenticate
    deny_access unless signed_in?
  end

  def current_candidate?(candidate)
    candidate == current_candidate
  end

  def deny_access
    store_location
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def sign_in(candidate)
    #:expire_after => -355.minutes          :expires => 2.minutes.from_now
    #cookies[:remember_token] = {:expires => 2.minutes.from_now }
    #cookies.signed[:remember_token] = {:expires => 2.minutes.from_now }
    cookies.signed[:remember_token] = [candidate.id, candidate.salt]  
    current_candidate = candidate
    logger.debug "\033[0;31mCANDIDATE ID: #{current_candidate.id}\033[0;37m"
    #cookies[:remember_token] = { expires: 1.hour.from_now }
    #cookies[:remember_token] = {:expires => 2.minutes.from_now}
    end

  def followed_in? (candidate)
    current_candidate != candidate
  end

  def is_follow? (candidate)
    @follow = current_candidate.followings.find_by_followed_id(candidate)
    !@follow.nil?
  end

  def current_candidate
    @current_candidate ||= candidate_from_remember_token
  end

  def signed_in?
    #If 'false', candidate exists
    !current_candidate.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    current_candidate = nil
  end

  def has_admin_role?

    puts "\nsessions_helper#has_admin_role?".green

    #['Admin', 'Super Admin'].include? ( get_user_type )
    role > SessionsHelper::USER

  end

  def set_my_wall (candidate)

    session[:my_wall_candidate_id] = candidate.nil? ? nil : candidate.id

  end

  def get_my_wall
    if session[:my_wall_candidate_id].nil?
      nil
    else
      Candidate.find(session[:my_wall_candidate_id])
    end
  end


  private
    def candidate_from_remember_token
      Candidate.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
      #cookies.signed[:remember_token] = {:expires => 2.minutes.from_now }
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

    def authCandidateInPopEmailServer(email, password)
      begin
        Net::POP3.auth_only('pop.4thsource.com', 110, email, password)
        return true
      rescue Net::POPAuthenticationError
        return false
      end
    end

    def role

      puts "\nsessions_helper#role".green

      puts "\n#{current_candidate}".red

      if !current_candidate.nil?

        puts "\ncurrent_candidate.id: #{current_candidate.id}".yellow

        #1

        if !current_candidate.admin_users.nil? && current_candidate.admin_users.count > 0
          
          puts "\n#{!current_candidate.admin_users.nil?}".cyan
          
          current_candidate.admin_users.each do |p|
            puts "#{p}".magenta
          end
          
          if !current_candidate.admin_users.first.is_active
            
            puts "\n!current_candidate.admin_users.first.is_active".cyan
            
            0
          elsif current_candidate.admin_users.first.is_active && !current_candidate.admin_users.first.lvl
            
            puts "\ncurrent_candidate.admin_users.first.is_active && !current_candidate.admin_users.first.lvl".cyan
            
            1
          elsif current_candidate.admin_users.first.is_active && current_candidate.admin_users.first.lvl
            
            puts "\ncurrent_candidate.admin_users.first.is_active && current_candidate.admin_users.first.lvl".cyan
            
            2
          end
        else
          0
        end
      else
        -1
      end
    end

    def validateEmail4thSource(email)

      puts "\nvalidateEmail_regex".red

     #email_regex = %r{
	       #^
         #[0-9a-z]+
         #[\.]
         #[0-9a-z]+
         #@
         #4thsource
         #[\.]
         #com
		     #$
      #}xi*/

      email_regex = %r{
	       ^
         [0-9a-z]+
         @
         4thsource
         [\.]
         com
		     $
      }xi

      #^ Start of the string
      # $ End of string

      #if (email =~ email_regex) != nil
        #true
      #else
        #false
      #end

	    return true if email =~ email_regex
      false
    end
end
