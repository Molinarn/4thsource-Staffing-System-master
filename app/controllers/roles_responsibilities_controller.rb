class RolesResponsibilitiesController < ApplicationController
  
  def new

    puts "\nroles_responsibility#new".green

    puts "\n:role_id: #{params[:role_id]}".magenta

    params.each do |p|
      puts "#{p}".cyan
    end

    #@candidate = current_candidate
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])

    @role = @projects_role.roles.find(params[:role_id])
    @title = @role.name + " in " + @project.name

    if request.post?

      puts "\nrequest.post".red

      puts "\nrole_id: #{params[:rolerespon][:role_id]}".blue

      puts "\nparams[:rolerespon]".yellow

      params[:rolerespon].each do |p|
        puts "#{p}"
      end

      puts "\ndescription: #{params[:rolerespon][:description]}".blue

      @rolerespon = @role.roles_responsibilities.build(:description => params[:rolerespon][:description])

      puts "\n@candidate_id: #{@candidate.id}".cyan
      puts "\n@project_id: #{@project.id}".cyan
      puts "\n@project_role_id: #{@projects_role.id}".cyan
      puts "\n@role_id: #{@role.id}".cyan
      puts "\n@rolerespon_id: #{@rolerespon.id}".cyan

      if @rolerespon.save

        puts "\nredirect".red

        flash[:success] = "Project was saved successfully."
        render 'roles_responsibilities/new'

      else
        flash[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projects_role  = @project.projects_roles.find(params[:projects_role_id])
      #@title = Role.find_by_projects_role_id(@projects_role.id).name + " in " + @project.name
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
