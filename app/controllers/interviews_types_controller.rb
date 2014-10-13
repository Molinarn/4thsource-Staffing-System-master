class InterviewsTypesController < ApplicationController
  
  def index
    set_wall_candidate(nil)
    set_my_wall(nil)
  end
   
  def new
    if request.post?
      @interview_type = InterviewsType.new(params[:interviewtype])
      if @interview_type.save
        flash[:success] = "Interview type was saved successfully."
        redirect_to File.join('/staff/', current_candidate.id.to_s, '/interviews_types', @interview_type.id.to_s, '/edit' )
      else
        if @interview_type.id.to_s.empty?
          flash[:notice] = "The interview type can not be null."
        else
          flash[:notice] = "An error occurred while the system save the interview type."
        end
      end
    else
      @interview_type  = InterviewsType.new
      @error = @interview_type.errors
    end    
  end

  def edit
    if request.post?
      @interview_type = InterviewsType.find(params[:interview_type_id])
      @interview_type.update_attributes(params[:interviews_type])
      if @interview_type.save
        flash[:success] = "Interview type was saved successfully."
        redirect_to File.join('/staff/', current_candidate.id.to_s, '/interviews_types')
      else
        flash[:notice] = "An error occurred while the system save the interview type."
      end
    else
      @interview_type = InterviewsType.find(params[:interview_type_id])
      @error = @interview_type.errors
    end
  end
  
  def delete
    @candidateInterview = CandidatesInterview.where("interview_type_id = ?", params[:interview_type_id])
    if @candidateInterview.length > 0
      flash[:notice] = "This Interview type is associated to an Interview, cannot be Deleted"
    else
      InterviewsType.find(params[:interview_type_id]).destroy
    end
    render :index
  end  

  def search
    
    if params[:interview_type_id].to_f > 0
      @interviews_type = InterviewsType.find(params[:interview_type_id])
      #@interviewers =  Interviewer.find_by_name(InterviewsType.find(params[:interview_type_id]).name)
    else
      @interviews_type = InterviewsType.new
    end
    render :search, :layout => false
  end
end
