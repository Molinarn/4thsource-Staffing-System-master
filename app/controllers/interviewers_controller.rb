class InterviewersController < ApplicationController

  def index

    puts "\ninterviewers#index".green

    set_wall_candidate(nil)
    set_my_wall(nil)
  end
  
  def new

    puts "\ninterviewers#new".green

    params.each do |p|
      puts "#{p}".cyan
    end

    @candidate = Candidate.find(params[:id])
    @interviewer_user = @candidate.interviewer_users.new

    if request.post?

      @interviewer = Interviewer.new(params[:interviewer])
      if @interviewer.save

        @interviewer_user.interviewer_id = @interviewer.id
        @interviewer_user.save

        flash[:success] = "Interviewer was saved successfully."
        #render 'index'
        redirect_to File.join('/staff/', current_candidate.id.to_s, '/interviewers')
      else
        @nterviewer.errors.full_messages.each do |msg|
          flash[:notice] = msg
        end
      end
    else
      @interviewer  = Interviewer.new
      @error = @interviewer.errors
    end    
  end

  def edit

    puts "\ninterviewers#edit".green

    if request.post?
      @interviewer = Interviewer.find(params[:interviewer_id])
      @interviewer.update_attributes(params[:interviewer])
      if @interviewer.save
        flash[:success] = "Interviewer was saved successfully."
        render 'index'
      else
        flash[:notice] = "An error occurred while the system save the interviewer."
      end
    else
      @interviewer  = Interviewer.find(params[:interviewer_id])
      @error = @interviewer.errors
    end
    #@candidates = Candidate.joins(:interviewer_user).where(:interviewer_users => {:interviewer_id => @interviewer.id}).paginate(:page => params[:page],:per_page => 20,:order => 'first_last_name')
    @candidates = Candidate.joins(:interviewer_users).where(:interviewer_users => {:interviewer_id => @interviewer.id}).paginate(:page => params[:page],:per_page => 20,:order => 'first_last_name')
  end
  
  def delete

    puts "\ninterviewers#delete".green

    params.each do |p|
      puts "#{p}".cyan
    end

    #@interviewer = CandidatesInterview.find(params[:interviewer_id])
    @candidate_interview = CandidatesInterview.find_by_interviewer_user_id(InterviewerUser.find_by_interviewer_id(params[:interviewer_id]))
    #if @candidate_interview.length > 0
    if !@candidate_interview.nil?
      flash[:notice] = "This Interviewer is associated to an Interview, cannot be Deleted"
    else
      Interviewer.find(params[:interviewer_id]).destroy
    end
    render :index
  end

end
