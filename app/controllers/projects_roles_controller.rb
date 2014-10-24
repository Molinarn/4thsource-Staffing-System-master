class ProjectsRolesController < ApplicationController

  def new

    #@candidate = current_candidate

    puts "\nprojects_roles#new".green

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    #@projects_role = @project.projects_roles.find_by_project_id(@project_id)
    @projects_role = ProjectsRole.find_by_project_id(@project.id)

    #@projects_role = @project.projects_roles.find_or_create_by(:project_id => @project.id)

    #@projects_role = ProjectsRole.find_by_project_id(@project.id)

    #if ProjectsRole.find_by_project_id(@project.id).nil?

      #puts "\nprojects_role == nil".red

      #@projects_role = @project.projects_roles.new
      #@projects_role.save

    #else

      #@projects_role = ProjectsRole.find_by_project_id(@project.id)

    #end

    #@roles = @projects_role.roles

    puts "\ncandidate_id: #{@candidate.id}".cyan
    puts "project_id: #{@project.id}".cyan
    puts "project_role_id: #{@projects_role.id}".cyan
    #puts "roles_id: #{@roles.id}".cyan

    #This is not working
    #@roles.each do |r|
      #puts "#{r.id}".cyan
    #end

    if request.post?

      puts "\nrequest.post".magenta

      #@candidate = Candidate.find(params[:id])
      #@project = @candidate.projects.find(params[:project_id])

      params[:projects_role].each do |p|
        puts "#{p}".cyan
      end

      #@projects_role = @project.projects_roles.build(params[:projects_role])

      #updated = @projects_role.update_attributes(params[:projects_role])

      @projects_role.date_in = params[:projects_role][:date_in]
      @projects_role.date_out = params[:projects_role][:date_out]

      #puts "\nupdated: #{updated}".blue

      #puts "\n@role.nil? #{@roles.nil?}\n".red

      #@role.each do |r|
      #puts "#{r}".cyan
      #end

      new_role = params[:new_role_id]

      new_role.each do |r|
        puts "#{r}".cyan
      end

      #Return a collection of roles
      #actual_roles = Role.find_by_projects_role_id(@projects_role.id)

      actual_roles = @projects_role.roles

      if actual_roles.nil? || actual_roles.where("name = ?", new_role).count == 0

          @role = @projects_role.roles.new(:name => new_role)
          #@role.save

      else

        actual_roles.each do |r|
          puts"#{r}".cyan
        end

      end

      projtag = @projects_role.projects_tags.new
      projtag.save
      #@projects_role.update_attributes(params[:projects_role])

      #@newRole = @projects_role.roles.new
      #@newRole.name = Role.find(@role).name
      #@newRole.save

      #if @projects_role.save
      if @role.save
      #if updated
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
  end

  def show

    puts "\nprojects_roles#show".green

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])

  end

  def update

    puts "\nprojects_roles#update".green

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
    #ProjectsRole.find(params[:projects_role_id]).destroy
    #render 'projects/show'
    Role.find(params[:role_id]).destroy
    redirect_to :back
  end
  
  private 
    def correct_candidate
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end
    
end
