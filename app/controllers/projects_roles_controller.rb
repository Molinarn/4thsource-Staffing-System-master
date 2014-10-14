class ProjectsRolesController < ApplicationController

  def new

    #@candidate = current_candidate

    puts "\nprojects_roles#new".green

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])

    if request.post?
      #@candidate = Candidate.find(params[:id])
      #@project = @candidate.projects.find(params[:project_id])
      @projects_role = @project.projects_roles.build(params[:projects_role])

      if @projects_role.save
        flash[:success] = "Role was saved successfully."
        #render 'projects/show'
        render 'projects_roles/new'        
      else
        flash[:notice] = "An error occurred while the system save the role."
      end
    else
      #@candidate = Candidate.find(params[:id])
      #@project = @candidate.projects.find(params[:project_id])
      @projects_role  = ProjectsRole.new
      @error = @projects_role.errors
      @title = @project.name
    end

    #@role = @projects_role.roles.new

  end

  def show
    
  end

  def update
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projects_role = @project.projects_roles.find(params[:projects_role_id])
      @projects_role.update_attributes(params[:projects_role])
      if @projects_role.save
        flash[:success] = "Role was saved successfully."
        #render 'projects/show'
        render 'projects_roles/update'
      else
        @projects_role.errors.full_messages.each do |msg|
          flash[:notice] = msg
        end
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projects_role = @project.projects_roles.find(params[:projects_role_id])
      @error = @project.errors
      @roles_items = Role.all
    end
  end
  
  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])
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
