class RolesResponsibilitiesController < ApplicationController
  
  def new
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projectsrole = @project.projects_roles.find(params[:projects_role_id])
      @rolerespon = @projectsrole.roles_responsibilities.build(params[:rolerespon])
      if @rolerespon.save
        flash[:success] = "Project was saved successfully."
        render 'roles_responsibilities/new'               
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projectsrole  = @project.projects_roles.find(params[:projects_role_id])
      @title = Role.find(@projectsrole.role_id).name + " in " + @project.name
      @rolerespon = RolesResponsibility.new
      @error = @rolerespon.errors
    end
  end

  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projectsrole = @project.projects_roles.find(params[:projects_role_id])
    
    RolesResponsibility.find(params[:rolerespon_id]).destroy
    #render 'projects/show'
    redirect_to :back
  end
  
end
