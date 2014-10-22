class ProjectsTagsController < ApplicationController
  
  def new

    puts "\nprojects_tags#new".green

    @candidate = current_candidate
    @type = params[:type_id]

    case @type
      when "1"
        @tag_title = "Tool"
        @new_page = "projects_tags/new-tool"
      when "2"
        @tag_title = "Knowledge"
        @new_page = "projects_tags/new-knowledge"
      else
        @tag_title = "Technology"
        @new_page = "projects_tags/new-techology"
    end

    @tag = Tag.new(:name => @tag_title)
    @tag.save

    #@tags_type = ["Tool","Knowledge","Technology"]

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])

    #@projtag = @projects_role.projects_tags.new(params[:new_projtag_id])

    if request.post?

      puts "\nrequest.post".yellow

      params[:projtag].each do |t|
        puts "#{t}".cyan
      end

      @projtag = @projects_role.projects_tags.new(params[:projtag])
      @projtag.tags_id = @tag.id
      #@projtag.date_in = params[:date_in]
      #@projtag.date_out = params[:date_out]
      #@projtag.name = params[:new_projtag_id]

      #@candidate = Candidate.find(params[:id])
      #@project = @candidate.projects.find(params[:project_id])
      #@projects_role = @project.projects_roles.find(params[:projects_role_id])
      #@projtag = @projects_role.projects_tags.build(params[:projtag])
      if @projtag.save
        flash[:success] = @tag_title + " was saved successfully."
        render @new_page
      else
        flash[:notice] = "An error occurred while the system save the "+@tag_title + "."
        
        @projtag.errors.full_messages.each do |msg|
          flash[:notice] = msg
        end
        
        render @new_page
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projects_role  = @project.projects_roles.find(params[:projects_role_id])
      @title = @tag_title + " for " + Role.find_by_projects_role_id(@projects_role.id).name + " in " + @project.name
      @projtag = ProjectsTag.new
      @projtag.date_in = params[:date_in]
      @projtag.date_out = params[:date_out]
      @error = @projtag.errors
      render @new_page
    end
  end
  
  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projectsrole = @project.projects_roles.find(params[:projects_role_id])
    
    ProjectsTag.find(params[:projtag_id]).destroy
    #render 'projects/show'
    redirect_to :back;
  end
end