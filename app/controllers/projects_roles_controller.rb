class ProjectsRolesController < ApplicationController

  def new

    #@candidate = current_candidate

    puts "\nprojects_roles#new".green

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    #@projects_role = @project.projects_roles.find_by_project_id(@project_id)
    @projects_role = ProjectsRole.find_by_project_id(@project.id)
    @role = @projects_role.roles.last
    @title = @project.name

    puts "\n@role.nil?: #{@role.nil?}".red

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

      params.each do |p|
        puts "#{p}".cyan
      end

      #@projects_role = @project.projects_roles.build(params[:projects_role])

      #updated = @projects_role.update_attributes(params[:projects_role])

      #@projects_role.date_in = params[:projects_role][:date_in]
      #@projects_role.date_out = params[:projects_role][:date_out]

      #puts "\nupdated: #{updated}".blue

      #puts "\n@role.nil? #{@roles.nil?}\n".red

      #@role.each do |r|
      #puts "#{r}".cyan
      #end

      #puts "\nparams[:new_role_id]: #{params[:new_role_id] === ''? true:false}".yellow
      #puts "\nparams[:role][:id]: #{params[:role][:id] === ''? true:false}".yellow

      if params[:new_role_id] === ''
        if params[:role][:id] === '' 
          
          puts "\nnew_role: nil".red
          
          new_role = nil
          flash[:notice] = "Please select or add a role."
        else
          
          puts "\nnew_role: find".blue
          new_role = Role.find(params[:role][:id]).name
        end  
      else
        puts "\nnew_role: new name".blue          
        new_role = params[:new_role_id]
      end
      
      #Return a collection of roles
      #actual_roles = Role.find_by_projects_role_id(@projects_role.id)
      if !new_role.nil?
        
        puts "\n!new_role.nil?: #{!new_role.nil?}".red
        
        actual_roles = @projects_role.roles
  
        if actual_roles.nil? || actual_roles.where("name = ?", new_role).count == 0
  
            #@role = @projects_role.roles.new(params[:role])
            @role = @projects_role.roles.new
            @role.name = new_role
            @role.date_in = params[:role][:date_in]
            @role.date_out = params[:role][:date_out]
            #@role = @projects_role.roles.new(params[:role])
            #@role = @projects_role.roles.new(:name => new_role)
            #@role.save
  
        else
  
          actual_roles.each do |r|
            puts"#{r}".cyan
          end
  
        end
  
        #projtag = @projects_role.projects_tags.new
        #projtag.save
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
        render 'projects_roles/new' 
      end
    else
      #@candidate = Candidate.find(params[:id])
      #@project = @candidate.projects.find(params[:project_id])
      @projects_role  = ProjectsRole.new
      @error = @projects_role.errors
      #@title = @project.name
    end
  end

  def show

    puts "\nprojects_roles#show".green

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])
    #@role = @project_role.roles.find(params[:role_id])

  end

  def update

    puts "\nprojects_roles#update".green

    puts "\nparams[:role_id]: #{params[:role_id]}".magenta

    params.each do |p|
      puts "#{p}".cyan
    end

    #@candidate = current_candidate

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])
    @role = @projects_role.roles.find(params[:role_id])

    if request.post?

      puts "\nrequest.post".red

      #@projects_role.update_attributes(params[:projects_role])
      @role.update_attributes(:name => params[:new_role_id],
                              :date_in => params[:role][:date_in],
                              :date_out => params[:role][:date_out])

      #if @projects_role.save
      if @role.save
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
    @projects_role.roles.find(params[:role_id]).destroy

    #ProjectsRole.find(params[:projects_role_id]).destroy
    #render 'projects/show'
    #Role.find(params[:role_id]).destroy
    redirect_to :back
  end
  
  private 
    def correct_candidate
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end
    
end
