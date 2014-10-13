class FollowingsController < ApplicationController
  before_filter :authenticate

  def follow
    @candidate = Candidate.find(params[:id] )
    @follow = current_candidate.followings.build(:followed_id => @candidate.id)
    set_user_type(current_candidate)
    if @follow.save
      logger.info "following saved"
      @follow_candidate_id = @candidate.id
      render "following/_form", :layout => false
    else
      logger.info "following Error"
      flash[:success] = "Error"
      redirect_to @candidate
    end
  end
  
  def destroy
    set_user_type(current_candidate)
    @candidate = Candidate.find(params[:id])
    current_candidate.followings.find_by_followed_id(@candidate.id).destroy
    redirect_to @candidate
  end  

end
