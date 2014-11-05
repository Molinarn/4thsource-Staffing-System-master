class StaffCandidatesController < ApplicationController
  
  def index

    puts "\nstaff_candidates#index".green

    set_user_type(current_candidate)
    set_wall_candidate(nil)
    set_my_wall(nil)

    if current_candidate.admin_users
      user_level = get_user_level
      admin_users = AdminUser.all
      higher_level_users = []
   
      @candidates = Candidate.paginate(:page => params[:page], :per_page => 20).each do |candidate|
        higher_level_users << candidate if !is_lower_level(candidate, admin_users, user_level)
      end
	 
      higher_level_users.each do |candidate|
       @candidates.delete(candidate)
      end
	 
      @candidates.each do |candidate|
        @candidates.delete(candidate) if candidate.id == current_candidate.id
      end
    else
      @candidates = Candidate.joins(:candidates_interviews => :interviewer_user).where(:interviewer_users => {:candidate_id => current_candidate.id},:candidates_interviews => {:result => nil}).paginate(:page => params[:page], :per_page => 20)
    end
	 								   
  end

  def newcandidate
    
     puts "\ncandidates#newcandidate".green
    
     @candidate_admin = Candidate.find(params[:id])
    
     if request.post?
       
       puts "\nrequest.post? true".red
       
       params.each do |p|
         puts "#{p}".cyan
       end
       
       @candidate = Candidate.new(params[:candidate])
       
       if @candidate.save
         
         puts "\n@candidate.save".red
         
         redirect_to :controller => 'staff_candidates', :action => 'index', :method => 'post', :id => @candidate_admin.id
         
       else
         flash[:notice] = "Error while creating the candidate"
       end
      
     else
       
      render '/staff_candidates/newcandidate_admin'
       
     end
     
       #No such route
       #render '/staff_candidates/newcandidate_admin'
       #render :newcandidate_admin
       #render '/staff/newcandidate_admin'
     
  end

  def search

    puts "\nstaff_candidates#search".green

    if params[:q]
      query = params[:q]
      @users = User.find_with_ferret(query + "*", :limit => :all)
      @users = @users.sort_by{ |user| user.name}
      paginate(@users, 10)
      flash[:success] = "About #{@users.count} Results."
      render 'index'
    end
  end
  
  private
   
   def is_lower_level(candidate, admins, user_level)
     is_lower_lvl = true
	 admins.each do |admin|
	    is_lower_lvl = false if admin.candidate_id == candidate.id && admin.lvl > user_level
	 end
	 
	 is_lower_lvl
   end
   
   def get_user_level
   	user_level_maps = {'Admin' => 0, 'Super Admin' => 1}
	  user_level_maps[get_user_type]
   end
  
end
