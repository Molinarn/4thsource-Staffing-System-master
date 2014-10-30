class CandidatesInterviewsController < ApplicationController
  
  def index
    @candidate  = Candidate.find_by_id(params[:id])
    set_wall_candidate(@candidate)
    if current_candidate.interviewer_user and !current_candidate.admin_users
      
      @candidate.candidates_interviews.each do |interview|
        if interview.interviewer_user.candidate.id != current_candidate.id or 
          interview.result
          @candidate.candidates_interviews.delete(interview)
        end
      end 
 
    end
    @title = ' '
  end
  
  def new
    @jobs = Job.all
    @interviewers = InterviewsType.find(1).interviewer_users
    @candidate  = Candidate.find(params[:id])
    if request.post?
      @cand_inter = @candidate.candidates_interviews.build(params[:cand_inter])
      if @cand_inter.save
        doQuestions
        flash[:success] = "The interview was saved successfully."
        render :index
      else
        @cand_inter  = CandidatesInterview.new
        @interviewsType = InterviewsType.new
        @interviewsType.id = 0
        flash[:notice] = "An error occurred while the system save the interview data."
      end
    else
      @cand_inter  = CandidatesInterview.new
      @interviewsType = InterviewsType.new
      @interviewsType.id = 0
      @error = @cand_inter.errors
    end
  end
  
  def edit
    @candidate = current_candidate
    if request.post?
      @candidate = Candidate.find(params[:id])
      @cand_inter = @candidate.candidates_interviews.find(params[:cand_inter_id])
      @cand_inter.interviews_scores.each do |t_d|
        t_d.destroy
      end
      @cand_inter.update_attributes(params[:cand_inter])
      if @cand_inter.save
        doQuestions
        flash[:success] = "Interview was saved successfully."
        render 'index'
      else
        flash[:notice] = "An error occurred while the system save the interview."
      end
    else
      @candidate = Candidate.find(params[:id])
      @cand_inter = @candidate.candidates_interviews.find(params[:cand_inter_id])
    end
  end

  def report
    set_wall_candidate(nil)
    @interviews = CandidatesInterview.where("result IS NOT ?", nil)

    if request.post?

      filter = CandidatesInterviewFilter.new(params[:filter])

      if filter.by_WillingRelocate? or filter.by_ReferralType?
        @interviews = @interviews.joins(:candidate)

        if filter.by_WillingRelocate?
          @interviews = @interviews.where(:candidates => {:is_willing_to_relocate => filter.is_willing_to_relocate})
        end
   
        if filter.by_ReferralType?
          @interviews = @interviews.where(:candidates => {:referral_type => filter.referral_type})
        end

      end

      if filter.by_DateRange?
        @interviews = @interviews.where(:updated_at => filter.dateRange)
      end

      if filter.by_ResultRange?
        @interviews = @interviews.where(:result => filter.resultRange)
      end
 
      if filter.by_InterviewsType?
        @interviews =  @interviews.where(:interviews_type_id => filter.interviews_type_id)
      end

    end
    
    #@interviews = @interviews.paginate(:page => params[:page], :per_page => 15)

  end

  def view
    @cand_inter = CandidatesInterview.find(params[:cand_inter_id])
    @candidate = @cand_inter.candidate
    set_wall_candidate(nil)
  end


  def doit
    if request.post?
      @cand_inter = CandidatesInterview.find(params[:cand_inter_id])
      @candidate = @cand_inter.candidate
      @cand_inter.update_attributes(params[:candidates_interview])
      @cand_inter.result = "%.2f" % InterviewsScore.where(:candidates_interview_id => @cand_inter.id).average("score").to_f
      if @cand_inter.save
        flash[:success] = "Interview was saved successfully."
        redirect_to File.join('/candidates/', @candidate.id.to_s, '/candidates_interviews/', @cand_inter.id.to_s, '/view' )
      else
        flash[:notice] = "An error occurred while the system save the interview."
      end
    else
      @candidate = Candidate.find(params[:id])
      @cand_inter = @candidate.candidates_interviews.find(params[:cand_inter_id])
    end
  end 

  def delete
    @candidate = Candidate.find(params[:id])
    CandidatesInterview.find(params[:cand_inter_id]).destroy
    render 'index'
  end

  def status_process    
    @rowId = params[:rowId]
    #@cand_inter=CandidatesInterview.new
    #@candidate = current_candidate
    if @rowId.to_i != -1
      @temp = CandidatesInterview.new(params[:save_status_interview])

      #@cand_inter.id = params[:cand_inter][:interviewe_candidates_id]
      #@cand_inter = CandidatesInterview.find(params[:cand_inter_id])
      @t = CandidatesInterview.find(@temp.id)

      @temp.update_attributes(params[:save_status_interview])
      if @t.update_attributes(params[:save_status_interview])
        render text => "OK*M*#{@t.id.to_s}*M*" +
                      "<a href='#!' onclick=\"changeStatuse(#{@rowid},\'#{@t.statuses_id}\',\'#{@t.id}\');\">#{@t.statuses_id}</a>*M*" +
                      @t.statuses_id + "*M*"        
      end
    else    
      @t = CandidatesInterview.new(params[:save_status_interview])
      @t.type_tag = 2
      if @t.save      
        render text => "OK*M*#{@t.id.to_s}*M*" +
                    "<a href='#!' onclick=\"changeStatuse(#ROWID#,\'#{@t.statuse_id}\');\">#{@t.statuse_id}</a>*M*" +
                    @t.statuses_id + "*M*"         
      else
        render text => 'ERROR*Error while saving'
      end
    end
  end

  private

    def doQuestions
      @cand_inter.interviews_type.interviews_questions.each do |q|
        @score = InterviewsScore.new
        @score.candidates_interview = @cand_inter
        @score.question = q.question
        @score.save
      end
    end

end
