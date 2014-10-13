class ExperienceDetailsController < ApplicationController
  def new
    @candidate = Candidate.find(params[:id])
    @experience = Experience.find(params[:experience_id])
    if request.post?
      @experience_details = @experience.experience_details.new(params[:experience_details])
      if @experience_details.save
        flash[:success] = "Details for the project was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the details."
      end
    end
  end
  
  def destroy
    ExperienceDetail.find(params[:id]).destroy
    redirect_to request.referer
  end
end
