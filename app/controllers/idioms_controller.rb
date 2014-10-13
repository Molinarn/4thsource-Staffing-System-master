class IdiomsController < ApplicationController
  
  def index
    @candidate = current_candidate
    @error = @candidate.errors
    
    if @candidate.resume.nil?
      @candidate.build_resume.save
    end
    @total_idioms = @candidate.resume.idioms
  end
  
  def new
    @candidate = current_candidate
    @idiom = @candidate.resume.idioms.new(params[:idiom])
    @error = @idiom.errors
    
    if @idiom.save
      flash[:success] = "Idiom was saved successfully."
    else
      flash[:notice] = "An error occurred while the system save the idiom."
    end
    
    redirect_to request.referer
  end
  
  def destroy
    Idiom.find(params[:id]).destroy
    redirect_to request.referer
  end
end
