class SkillsController < ApplicationController
  def index
    @candidate = current_candidate
    if params[:letter].nil?
      @page_results = Skill.find(:all, :order => "name ASC")
    else
      @page_results = Skill.where("name like ?", "#{params[:letter]}%")
    end
    paginate(@page_results, 10)
  end
  
  def new
    @candidate = current_candidate
    @error = @candidate.errors
    if request.post?
      @skill = Skill.new(params[:skill])
      @error = @skill.errors
      if @skill.save
        flash.now[:success] = "Skill was saved successfully."
      end
    end
  end
end
