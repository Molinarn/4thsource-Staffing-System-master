class EducationsController < ApplicationController
  
  def destroy
    Education.find(params[:id]).destroy
    redirect_to request.referer
  end
end
