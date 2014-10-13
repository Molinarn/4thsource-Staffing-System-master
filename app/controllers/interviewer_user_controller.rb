class InterviewerUserController < ApplicationController

  def new
    @interviewer = Interviewer.find(params[:interviewer_id])
    unless params[:letra].nil?
      @candidates = Candidate.where('first_last_name LIKE ?', params[:letra] + '%')
                             .order('first_last_name')
    else
      @candidates = Candidate.where('first_last_name LIKE "a%"')
                             .order('first_last_name')
    end
  end

  def add
    @iu = InterviewerUser.where(:candidate_id => params[:candidate_id], :interviewer_id => params[:interviewer_id])
    if @iu.nil? or @iu.empty?
      @interviewerUser = InterviewerUser.new
      @interviewerUser.candidate = Candidate.find(params[:candidate_id])
      @interviewerUser.interviewer = Interviewer.find(params[:interviewer_id])
      if @interviewerUser.save
        flash[:notice] = "User added successfuly"
      else
        flash[:notice] = "There was an error please try again!"
      end
      redirect_to File.join('/staff/', current_candidate.id.to_s, '/interviewers', @interviewerUser.interviewer.id.to_s, '/edit' )      
    else
      flash[:notice] = "User already exists in interviewer catalog "
    end
  end

end
