class ProjectsTagsController < ApplicationController
  
  def new

    puts "\nprojects_tags#new".green

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

    @candidate = Candidate.find(params[:id])
    @project = @candidate.projects.find(params[:project_id])
    @projects_role = @project.projects_roles.find(params[:projects_role_id])

    @title = @tag_title + " for "+  @project.name

    if @projects_role.projects_tags.nil?
        @projtag = @projects_role.projects_tags.new
    else
        @projtag = @projects_role.projects_tags.find_by_projects_role_id(@projects_role.id)
    end

    if request.post?

      puts "\nrequest.post".yellow

      params.each do |t|
        puts "#{t}".cyan
      end

      #puts "\n@projtag.nil?: #{@projtag.nil?}".red

      #puts "\n#{params[:projtag][:date_in]} - #{params[:projtag][:date_out]}".blue

      puts "\n@projtag.save: #{@projtag.save}".red

      if params[:new_projtag_id] == ''
        if params[:projtag].nil?
          flash[:notice] = "Please Select or Add a " + @tag_title
          @tag = nil
          #render @new_page
        else
          #selected_tag = Tag.find(params[:projtag][:id])
          
          if @projtag.tags.where("id = ?",params[:projtag][:id]).count <= 0
            @tag = @projtag.tags.new
            @tag.type_tag = @type
            @tag.name = Tag.find(params[:projtag][:id]).name
            @tag.description = params[:projtag][:description]
            @tag.date_in = params[:projtag][:date_in]
            @tag.date_out = params[:projtag][:date_out]
          else
            flash[:notice] = @tag_title + " Already Assigned."
            @tag = nil
            #render @new_page
          end
        
        end
        
      else
        if @projtag.tags.where("name = ?", params[:new_projtag_id]).count > 0
          flash[:notice] = @tag_title + " Already Assigned."
          @tag = nil
          #render @new_page  
        else
          @tag = @projtag.tags.new
          @tag.type_tag = @type
          @tag.name = params[:new_projtag_id]
          @tag.description = params[:projtag][:description]
          @tag.date_in = params[:projtag][:date_in]
          @tag.date_out = params[:projtag][:date_out]
        end
      end
      
      if !@tag.nil?
        @tag.save
        flash[:success] = @tag_title + " was saved successfully."
        render @new_page
      else
        #flash[:notice] = "An error occurred while the system save the "+@tag_title + "."
        
        #@projtag.errors.full_messages.each do |msg|
          #flash[:notice] = msg
        #end
        
        render @new_page
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = @candidate.projects.find(params[:project_id])
      @projects_role  = @project.projects_roles.find(params[:projects_role_id])
      @projtag = @projects_role.projects_tags.find_by_projects_role_id(@projects_role.id)
      #@title = @tag_title + " for "+  @project.name
      #@error = @projtag.errors
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