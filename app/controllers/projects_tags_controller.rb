class ProjectsTagsController < ApplicationController
  
  def new

    puts "\nprojects_tags#new".green

    #@candidate = current_candidate
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

    #@tag = Tag.new(:name => @tag_title)
    #@tag.save

    #@tags_type = ["Tool","Knowledge","Technology"]

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])

    if @projects_role.projects_tags.nil?
        @projtag = @projects_role.projects_tags.new
    else
        @projtag = @projects_role.projects_tags.find_by_projects_role_id(@projects_role.id)
    end

    #@projtag = @projects_role.projects_tags.new(params[:new_projtag_id])

    if request.post?

      puts "\nrequest.post".yellow

      params[:projtag].each do |t|
        puts "#{t}".cyan
      end

      #@projtag = @projects_role.projects_tags.new

      puts "\n@projtag.nil?: #{@projtag.nil?}".red

      puts "\n#{params[:projtag][:date_in]} - #{params[:projtag][:date_out]}".blue

      #@projtag.date_in = params[:projtag][:date_in]
      #@projtag.date_out = params[:projtag][:date_out]

      puts "\n@projtag.save: #{@projtag.save}".red

      @tag = @projtag.tags.new
      @tag.type_tag = @type
      @tag.name = params[:new_projtag_id]
      @tag.description = params[:projtag][:description]
      @tag.date_in = params[:projtag][:date_in]
      @tag.date_out = params[:projtag][:date_out]
      #@tag.save

      #@projtag.tags_id = @type
      #@projtag.tags_id = @tag.id
      #@projtag.date_in = params[:date_in]
      #@projtag.date_out = params[:date_out]
      #@projtag.name = params[:new_projtag_id]

      #@candidate = Candidate.find(params[:id])
      #@project = @candidate.projects.find(params[:project_id])
      #@projects_role = @project.projects_roles.find(params[:projects_role_id])
      #@projtag = @projects_role.projects_tags.build(params[:projtag])
      #if @projtag.save

      #if @projtag.save && @tag.save
      if @tag.save

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
      #@projtags = ProjectsTag.find_by_projects_role_id(@projects_role.id)
      @projtag = @projects_role.projects_tags.find_by_projects_role_id(@projects_role.id)
      #@title = @tag_title + " for " + Role.find_by_projects_role_id(@projects_role.id).name + " in " + @project.name
      @title = @tag_title + " for "+  @project.name
      #@tag = @projtag.tags.new
      #@projtag = ProjectsTag.new
      #@projtag.date_in = params[:date_in]
      #@projtag.date_out = params[:date_out]
      @error = @projtag.errors
      render @new_page
    end
  end
  
  def destroy
    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projectsrole = @project.projects_roles.find(params[:projects_role_id])
    
    @projtag = ProjectsTag.find(params[:projtag_id])
    Tag.find(params[:tag_id]).destroy
    #render 'projects/show'
    redirect_to :back
  end
end