class ProjectsRolesController < ApplicationController

  def new

    #@candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projectsrole = @project.projects_roles.build(params[:projectsrole])
      if @projectsrole.save
        flash[:success] = "Role was saved successfully."
        #render 'projects/show'
        render 'projects_roles/new'        
      else
        flash[:notice] = "An error occurred while the system save the role."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @title = @project.name
      @projectsrole  = ProjectsRole.new
      @error = @projectsrole.errors
    end
  end

  def show
    
  end

  def update
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projectsrole = @project.projects_roles.find(params[:projects_role_id])
      @projectsrole.update_attributes(params[:projectsrole])
      if @projectsrole.save
        flash[:success] = "Role was saved successfully."
        #render 'projects/show'
        render 'projects_roles/update'
      else
        @projectsrole.errors.full_messages.each do |msg|
          flash[:notice] = msg
        end
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projectsrole = @project.projects_roles.find(params[:projects_role_id])
      @error = @project.errors
      @roles_items = Role.all
    end
  end
  
  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projectsrole = @project.projects_roles.find(params[:projects_role_id])
    ProjectsRole.find(params[:projects_role_id]).destroy
    #render 'projects/show'
    redirect_to :back
  end
  
  private 
    def correct_candidate
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end
    
end
