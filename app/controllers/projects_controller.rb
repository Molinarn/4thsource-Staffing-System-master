
require 'ProfileBuilder2'

class ProjectsController < ApplicationController
  before_filter :authenticate
  #before_filter :correct_candidate

  def index
    @candidate  = Candidate.find_by_id(params[:id])
    #@microposts = @candidate.microposts.paginate(:page => params[:page])
    @title = @candidate.first_name+' '+@candidate.first_last_name

    if @candidate.projects.nil?
      @projects_items = @candidate.build_projects
      @projects_items.save
    else
      @projects_items = @candidate.projects
    end
    
  end

  def profile
    @candidate = Candidate.find_by_id(params[:id])
    @title = "Make Profile"
    #render :layout => 'new'
  end

  def buildprofile
    @builder = ProfileBuilder2.new
    @builder.filter = ""
    if params[:filter] != nil
      @builder.filter = params[:filter]
    end
    @builder.summaryprof = params[:summaryprof] if (params[:summaryprof] != nil)
    @builder.nameprof = params[:nameprof] if (params[:nameprof] != nil)
    @builder.candidate_id = params[:id]
    @filename = @builder.build
    File.open(@filename, 'rb') do |f|
      send_data f.read, :type => "application/msword", :disposition => "inline", :filename => "profile" + Time.now().to_s + ".docx"
    end    
  end

  def show
    
    #@candidate = current_candidate
    @candidate = Candidate.find(params[:id])

    if request.post?

      @project = Project.find(params[:project_id])
      @project.update_attributes(params[:project])
      if @project.save
        flash.now[:success] = "Project was saved successfully."
        @projects_items = @candidate.projects
        render :index
      else
        flash.now[:notice] = "An error occurred while the system save the project."
      end
    else
      @candidate = Candidate.find(params[:id])
      @project = Project.find_by_id(params[:project_id])
      @title = @project.name
      @projects_role  = ProjectsRole.new
      @roles_items = Role.all
    end
    
    
  end
  
  def prepare_project_form
    @project = Project.new
  end
  
  def new
    #@candidate = current_candidate
    @candidate = Candidate.find(params[:id])
    
    if request.post?

      @project = @candidate.projects.build(params[:project])
      if @project.save
        flash.now[:success] = "Project was saved successfully."
        @projects_items = @candidate.projects
        #render :index
             if @candidate.projects.empty?
          redirect_to :controller => 'projects', :action => 'new', :method => 'post', :id => @candidate.id
         elsif @candidate.candidate_education.empty?
          redirect_to :controller=>'candidate_education', :action => 'new', :id => @candidate.id, :method => 'get'
            elsif @candidate.candidate_languages.empty?
                redirect_to :controller=>'candidate_languages', :action => 'index', :candidate_id => @candidate.id, :method => 'get'
                   else 
                     render :index
                        
              

        end
      else
        flash.now[:notice] = "An error occurred while the system save the project."
      end
    else
      @project  = Project.new
      @error = @project.errors
    end
  end
  
  def update
    @candidate = current_candidate
    
    if request.post?
      @candidate = Candidate.find(params[:id])
      @project = Project.find(params[:project_id])
      @antes= @project.name
      @project.update_attributes(params[:project])
      @despues= @project.name
      if @project.save
        flash.now[:success] = "Project was saved successfully."
        @projects_items = @candidate.projects
        render :index
      else
        flash.now[:notice] = "An error occurred while the system save the project2. " + @project.errors.to_xml
      end
    else
      @project = Project.find_by_id(params[:project_id])
      @error = @project.errors
      @roles_items = Role.all
    end
  end
  
  def skill
    @candidate = Candidate.find(params[:id])  
    @project = @candidate.resume.projects.find(params[:project_id])
    if request.post?
       @flag = params[:skill_id][:id]
       if @project.skills.find_by_id(@flag).nil? && !@flag.empty?
         if @project.tools.new(:skill_id => @flag).save
           flash.now[:success] = "Project was saved successfully."
         else
           flash.now[:notice] = "An error occurred while the system save the project."
         end
       else
         flash.now[:notice] = "You tried to save a exists or empty Project in this project. Please choose another and try again."
       end
    end
  end

  def techs
    if params[:id] != nil
      @Current = Technologies.find_by_sql(["SELECT a.* FROM technologies a
                                            JOIN projects_tags_technologies b ON a.id = b.tech_id
                                            WHERE b.project_tag_id = ? AND a.lang_id = ?", params[:role_id], params[:platform_id]])
      @Techs = Technologies.where("technologies.lang_id = ?", params[:platform_id])

      render partial => "techs"
    end
  end

  def techs_save
    @resp = "OK"
    CustomQueries.deleteTechnologies(params[:role_id], params[:platform_id])
    params[:chk].each do |x, y|
      @t = ProjectsTagsTechnology.new({
        :project_tag_id => params[:role_id],
        :tech_id => y
      })
      if !@t.save
        @resp = "Error while saving"
      end
    end
    #render text: @resp
    render text = @resp
  end
  
  def destroy
    Project.find(params[:project_id]).destroy
    #@candidate = Candidate.find(params[:id])
    #@projects_items = @candidate.projects
    render :index
  end
  
  private 
    def correct_candidate
      @candidate = Candidate.find(params[:id])
      redirect_to(root_path) unless current_candidate?(@candidate)
    end

end