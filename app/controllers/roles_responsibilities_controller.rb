class RolesResponsibilitiesController < ApplicationController
  
  def new

    puts "\nroles_responsibility#new".green

    #@candidate = current_candidate
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])
    @role = @projects_role.roles.find(params[:role_id])
    #@role = Role.find(params[:role_id])
    #@role_id = params[:role_id]

    #puts "\nrole_id: #{params[:role_id]}".magenta
    puts "\nrole_id: #{@role.id}".magenta

    if request.post?

      #puts "\n@role: #{@role.id}".cyan

      params[:rolerespon].each do |p|
        puts "#{p}"
      end

      @role = Role.find(params[:rolerespon][:role_id])
      #@role = Role.find_by_projects_role_id(@projects_role.id)
      @rolerespon = @role.roles_responsibilities.build(params[:rolerespon][:description])

      puts "\n@candidate_id: #{@candidate.id}".cyan
      puts "\n@project_id: #{@project.id}".cyan
      puts "\n@project_role_id: #{@projects_role.id}".cyan
      puts "\n@role_id: #{@role.id}".cyan
      puts "\n@rolerespon_id: #{@rolerespon.id}".cyan

      if @rolerespon.save
        flash[:success] = "Project was saved successfully."
        render 'roles_responsibilities/new'               
      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projects_role  = @project.projects_roles.find(params[:projects_role_id])
      @title = Role.find_by_projects_role_id(@projects_role.id).name + " in " + @project.name
      @rolerespon = RolesResponsibility.new
      @error = @rolerespon.errors
    end
  end

  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])
    
    RolesResponsibility.find(params[:rolerespon_id]).destroy
    #render 'projects/show'
    redirect_to :back
  end
  
end
