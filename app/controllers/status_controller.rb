class StatusController < ApplicationController
  def index
    @statuses = Status.all
  end

  def create
    @status = Status.new(params[:status])

    @status.updated_by = current_candidate.first_name + " " + 
                        current_candidate.middle_name + " " + 
                        current_candidate.first_last_name + " " + 
                        current_candidate.second_last_name
    @status.save

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/candidate_status')
  end

  def destroy
    Status.delete(params[:id])

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/candidate_status')
  end
end