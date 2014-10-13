class CandidateTrainingController < ApplicationController
  before_filter :authenticate
  
   def index
    @candidate = current_candidate
    @error = @candidate.errors
    
    @total_trainings = @candidate.candidate_trainings
    @training = CandidateTraining.new

  end
 
  def new
    @candidate = current_candidate
    @candidate_training = @candidate.candidate_trainings.build(params[:candidate_training])
    
      if @candidate_training.save
        flash[:success] = "training was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the trainings#{@candidate_training.errors.as_json}"
      end
    redirect_to request.referer 
  end
  
  def destroy
    candidate_training = CandidateTraining.find(params[:id])
    if(candidate_training != nil)
     candidate_training.destroy
    end 
    redirect_to request.referer
  end
end
