class StaffCandidatesController < ApplicationController
  
  def index
    set_user_type(current_candidate)
    set_wall_candidate(nil)
    set_my_wall(nil)

    if current_candidate.admin_users
      user_level = get_user_level
      admin_users = AdminUsers.all
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
      @candidates = Candidate.joins(candidates_interviews: :interviewer_user)
                             .where(interviewer_users: {:candidate_id => current_candidate.id}, 
                                    candidates_interviews: {:result => nil})
                             .paginate(:page => params[:page], :per_page => 20)
    end
	 								   
  end

  def search
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
	    is_lower_lvl = false if admin.candidates_id == candidate.id && admin.lvl > user_level
	 end
	 
	 is_lower_lvl
   end
   
   def get_user_level
   	user_level_maps = {'Admin' => 0, 'Super Admin' => 1}
	user_level_maps[get_user_type]
   end
  
end
