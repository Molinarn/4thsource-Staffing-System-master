class SessionsController < ApplicationController
  
  skip_filter :verify_signed_in, :only => [:new, :create, :destroy]
   

  def new # is called every time you go to the login view

    puts "\nsession#new".green

    #Candidate.find(session[:remember_token])

   #signed_in defined at sessions_helper

    case (signed_in?)# is used to check if the user have a session active, and depending the case redirect to the appropriate page
       when true
      flash.now[:error] = "true.Session Active"
       #  cookies[:remember_token] = { value:   remember_token,
        #                     expires: 2.minutes.from_now.utc }
      #session[:expires_at] = Time.now + 2.minutes
      redirect_to :controller=>'resume', :action => 'index', :id => current_candidate.id, :method => 'get'
       # session[:expires_at] = Time.now + 30
      #session[:expires_at] = Time.now + 2.minutes
           #render "@resume = resume.index"
      when false

        puts "\nsigned_in == false".red

      flash.now[:error] = "false.No Session Active"
      #Does nothing when no session active
      else
    
    end
    @title = "Sign in"  

  end

  def create

    puts "\nsession#create".green

    @flag = false
    @var = [nil,"nil"]
    candidate = nil

    if validateEmail4thSource(params[:session][:email])

      puts "\nvalidEmail4thSource".yellow

      #if authCandidateInPopEmailServer(params[:session][:email], params[:session][:password])
        candidate = Candidate.find_by_email(params[:session][:email])    

        puts ["session_create/candidate: ".cyan, "#{candidate.email}"]

        #@flag = true

        @var[1] = "valid"

        #puts "\nauthCandidateInPop".yellow

      #end
    else

      puts "\nelse_validateEmail4thSource".yellow

      @var = Candidate.authenticate(params[:session][:email],params[:session][:password])
      #candidate = Candidate.authenticate_with_salt(params[:session][:email],params[:session][:password])
      #@flag = !var[1].nil?
      #@flag = !candidate.nil?
      candidate = @var[0]

    end



    #Wrong validation @flag = candidate.nil
    #if candidate.nil?
    if @var[1] === "nil"

      puts "\n@var[1]: #{@var[1]}".magenta

      #if @flag
        flash.now[:error] = "You do not have a profile. Please, go to Register now!."
      #else
    elsif @var[1] === "wrong"

        puts "\n@var[1]: #{@var[1]}".magenta

        flash.now[:error] = "Invalid email/password combination."
      #end
      @title = "Sign in"
      render :new
    else

      puts "\n@var[1]: #{@var[1]}".magenta

      if set_user_type(candidate)
        sign_in(candidate)
        #redirect_back_or root_path
        puts "\nSuccessfully LogIn".blue
        redirect_back_or edit_candidate_path(current_candidate.id)
      else
        flash.now[:error] = "Please contact the system administrator, your account is not active!"
	      @title = "Sign in"
        render :new
       end
    end
	
  end


=begin
  def create
    @flag = false
    candidate = Candidate.authenticate(params[:session][:email],params[:session][:password])
    if candidate.nil?
      if @flag
        flash.now[:error] = "You do not have a profile. Please, go to Register now!."
      else
        flash.now[:error] = "Invalid email/password combination."
      end
      @title = "Sign in"
      render :new
    else
      sign_in candidate
      redirect_back_or root_path
    end
  end
=end

  def destroy
    sign_out
	  session[:user_type] = nil
    redirect_to root_path
  end
  
end
