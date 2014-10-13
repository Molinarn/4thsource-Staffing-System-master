class UserWallsController < ApplicationController

  def show
    @candidate = Candidate.find(params[:id])
    set_wall_candidate(@candidate)
    @candidate["actual_name"] = "#{@candidate.first_name} #{@candidate.first_last_name}"
    @candidate["tweets"] = Micropost.where("candidate_id = ? OR created_by = ?", params[:id], params[:id])
  end

end
