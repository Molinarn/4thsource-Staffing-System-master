class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  helper :date
  helper_method :set_user_type, :get_user_type, :set_wall_candidate, :get_wall_candidate
  before_filter :verify_signed_in

 

  def verify_signed_in
    unless signed_in?
      redirect_to '/signin' if request.path != '/'
    end
  end
  
  @@admin_roles = ['Admin', 'Super Admin']

  def set_user_type(user)
  
    #admin_user = AdminUsers.find_by_candidates_id(user.id)
    admin_user = AdminUser.find_by_candidate_id(user.id)
    roles = {'0' => 'Admin', '1' => 'Super Admin'}
	
    if admin_user 
      if admin_user.is_active
        session[:user_type] = admin_user.lvl.nil? ? 'Admin' : roles[admin_user.lvl.to_s]
      else
        session[:user_type] = 'Candidate' 
       # session[:expires_at] = 2.minutes.from_now 
      end
    else
      session[:user_type] = 'Candidate'
      #session[:expires_at] = 2.minutes.from_now
    end

    session[:user_type]
  end
  

  def get_user_type
    session[:user_type]
  end

  def set_wall_candidate (candidate)
    session[:wall_candidate_id] = candidate.nil? ? nil : candidate.id
  end
 
  def get_wall_candidate
    if session[:wall_candidate_id].nil?
      nil
    else
      Candidate.find(session[:wall_candidate_id])
    end
  end

  def paginate(results, per_page)
    if(params[:page].to_i>0)
      current_page = params[:page].to_i
    else
      current_page = 1
    end    
    @page_results = WillPaginate::Collection.create(current_page, per_page, results.count) do |pager|
      start = (current_page-1)*per_page # assuming current_page is 1 based.
      pager.replace(results.to_a[start, per_page])
    end
  end
  
end

