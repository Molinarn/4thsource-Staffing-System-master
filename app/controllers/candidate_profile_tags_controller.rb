class CandidateProfileTagsController < ApplicationController
  def index
    @candidate  = Candidate.find_by_id(params[:candidate_id])
    #@microposts = @candidate.microposts.paginate(:page => params[:page])
    #@title = @candidate.first_name+' '+@candidate.first_last_name

    if @candidate.projects.nil?
      @projects_items = @candidate.build_projects
      @projects_items.save
    else
      @projects_items = @candidate.projects
    end  	
  end

  def create
  	@title = params[:tagId3]
  	logger.debug "*******************/////////////////"
  	logger.debug @title
  	logger.debug "*******************/////////////////"
  end
end
