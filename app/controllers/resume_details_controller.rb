class ResumeDetailsController < ApplicationController 
  before_filter :authenticate, only: [:destroy]

  def destro
    ResumeDetail.find(params[:id]).destroy
    redirect_to request.referer
  end 
end
