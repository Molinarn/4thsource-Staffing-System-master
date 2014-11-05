
class CandidatesController < ApplicationController
  #before_filter :authenticate, :except => [:show, :new, :create, :change]
  #before_filter :correct_user, :only => [:edit, :update]
  skip_filter :verify_signed_in, :only => [:new, :create]
  before_filter :admin_user,   :only => [:destroy]

  def index
    @candidate = Candidate.all
    @title = "All users"
    paginate(@candidate, 10)
    flash[:success] = "About #{@candidate.count} results."
  end

  def show
    @candidate  = Candidate.find(params[:id])
    @title = @candidate.name
  end

  def new

    puts "\ncandidate#new".green

    #Useless declaration !!
    current_candidate = @candidate

    @candidate  = Candidate.new
    @error = @candidate.errors
    @title = "Sign up"

  end

  def edit

    id = params[:id] unless params.blank?

    puts "\ncandidates#edit".green

    puts ["\nid: ".yellow,"#{id}".red]

    puts "\n#{@@admin_roles}".magenta

    if @@admin_roles.include?( get_user_type )

      puts "\nif_admin_roles".green

      @candidate = Candidate.find(id)
      @follow_candidate_id = @candidate.id
      @error = @candidate.errors
    else

      puts "\nelse_admin_roles".green

#      binding.pry
      @candidate = Candidate.find(current_candidate.id)

      puts ["\ncandidate_id: ".yellow,"#{@candidate.id}".red]

      @error  = current_candidate.errors
    end
    
    if current_candidate.id === @candidate.id

      #puts "\ncurrent_candidate.id === @candidate.id".green

      #set_wall_candidate(nil)

      #puts "\nset_wall_candidate(nil)".magenta

      set_my_wall(@candidate)

      puts "\nset_my_wall(@candidate)".magenta

      #get_my_wall(@candidate)

    end

    @title  = "Edit user"

  end

  def change
    if param_posted?(:user)
      @user = User.find(params[:id])
      @user.change_password_flag = nil
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated."
        redirect_to :signin
      else        
        render :change
      end
    else
      @user = User.find(params[:id])
      if @user && @user.change_password_flag == params[:code]
        @error = @user.errors
        render :change
      else
        flash[:notice] = "Invalid code!"
        redirect_to root_path
      end
    end
  end

  def create
  
    puts "\ncandidates#create".green
  
	  puts "\ncandidate.nil? #{current_candidate.nil?}".red

    #If no current_candidate, there's no login so act as new candidate.
    #if current_candidate.nil?
    if !current_candidate.nil?

      puts "\nget_user_type: #{get_user_type}".red

      if @@admin_roles.include?( get_user_type ) #!current_candidate.admin_flag.nil?
        #algo
        @candidate = Candidate.new(params[:candidate])
        @error = @candidate.errors

        if @candidate.save

          #UserMailer.welcome_email(@candidate).deliver
          #Se guardo, redireccionar al edit http://localhost:3000/candidates/6/admin
          @canditate.build_default_candidate_profile
          redirect_to "/candidates/#{@candidate.id}/edit" #"/candidates/#{@candidate.id}/admin"
        end
      end
	  
    else
	
	    #puts "\nCandidate: null".blue

      @candidate = Candidate.new(params[:candidate])
      @error = @candidate.errors

      #if !verify_recaptcha
        #@candidate.errors[:recaptcha] = "is invalid"
        #@title = "Sign up"
        #render :new
      #else
        if @candidate.save
        #if @candidate.valid?

          #puts "\n#{"candidate_attrs: "+params[:candidate].to_s}".blue

          #puts "\n#{@candidate.id}"

		      #set_user_type(@candidate)
          #sign_in @candidate
          #UserMailer.welcome_email(@candidate).deliver
          #flash[:success] = "Welcome to the Sample App!"
          # binding.pry

          @candidate.build_default_candidate_profile
          #flag = !@candidate.build_default_candidate_profile

          #puts "\nflag: " + "#{flag}"

          #if flag
            #@candidate.destroy
          #end

          redirect_to signin_path

        else
          @title = "Sign up"
          render :new
        end
      #end
	  
    end
	
  end

  def update
    #binding.pry
    @candidate = Candidate.find(params[:id])
    @error = @candidate.errors
    if @candidate != nil   
      if Candidate.update(params[:id].to_i, params[:candidate])
        flash[:success] = "Your profile was updated."
        @candidate = Candidate.find(params[:id])
      #  render :edit
        if @candidate.projects.empty?
          redirect_to :controller => 'projects', :action => 'new', :method => 'post', :id => @candidate.id
         elsif @candidate.candidate_education.empty?
          redirect_to :controller=>'candidate_education', :action => 'new', :id => @candidate.id, :method => 'get'
            elsif @candidate.candidate_languages.empty?
                redirect_to :controller=>'candidate_languages', :action => 'index', :candidate_id => @candidate.id, :method => 'get'
               #  elsif @Candidate.certification.empty?
                  # redirect_to :controller=>'certifications', :action => 'new', :candidate_id => @candidate.id, :method => 'get'
                  
                   else 
                    render :edit

        end

           
      else        
        render :edit
        # flash[:success] = "ELSE TEST."
      end

    else
      flash[:success] = "Error: candidate not found"
      render :edit
    end    
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    users_id = @user.followings.map(&:followed_id).join(", ")
    @users = User.where("id IN (#{users_id})").paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    users_id = @user.followers.map(&:id).join(", ")
    @users = User.where("id IN (#{users_id})").paginate(:page => params[:page])
    render 'show_follow'
  end

  def search
    if params[:q]
      query = params[:q]
      @users = User.find_with_ferret(query + "*", :limit => :all)
      @users = @users.sort_by{ |user| user.name}
      paginate(@users, 10)
      flash[:success] = "About #{@users.count} results."
      render 'index'
    end
  end

  def newcandidate_admin
    
    puts "\ncandidates#newcandidate".green
    
     @candidate = Candidate.new
     
     if request.post?
       if @candidate.save
         render '/candidates/index'
       else
         flash[:notice] = "Error while creating the candidate"
         render '/candidates/newcandidate'
       end
     end
     
     #No such route
     #render '/candidates/newcandidate_admin'
     render '/candidates/new'
  end  

  def profiles
    render text => "OK"
  end

  private
    def param_posted?(sym)
      request.post? and params[sym]
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def correct_user
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end
end
