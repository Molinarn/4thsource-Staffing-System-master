class CandidateProfSummariesController < ApplicationController
	before_filter :authenticate, only: [:destroy]

  def destroy
    CandidateProfSummary.find(params[:id]).destroy
    redirect_to request.referer
  end
end
