class RolesController < ApplicationController
  def index
    @roles = Role.all
    set_wall_candidate(nil)
    set_my_wall(nil)
  end

  def new

    puts "\nroles#new".green

    #@candidate = Candidate.find(params[:id])
    #@project = @candidate.projects.find(params[:project_id])
    #@projects_role = @project.projects_roles.find(params[:projects_role_id])

    if request.post?
      @role = Role.new(params[:role])
      #@role = @projects_role.new(params[:role])
      @cat_role_rows = Role.where("name = ?", @role.name)
      if @cat_role_rows.length > 0
        flash[:notice] = "The Role already exists"
      else
        if params[:role][:name].strip == ""
          flash[:notice] = "Name field is invalid."
        else
          @role.approved_flag = true
          @role.approved_by = current_candidate.first_name + " " + 
                                current_candidate.middle_name + " " + 
                                current_candidate.first_last_name + " " + 
                                current_candidate.second_last_name
          @role.save
          @role = Role.all
          redirect_to File.join('/staff/', current_candidate.id.to_s(), '/roles')
        end
      end
    else
      @role = Role.new
    end
  end

  def action
    @roles = Role.all

    if(params[:update_button] != nil)
      @roles.each do |row|
        @role = params["approved_flag_" + row.id.to_s()]
        row.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name
        if(@role == nil)
          Role.update(row.id, 
                      :approved_flag => false,
                      :approved_by => row.approved_by)
        else
          Role.update(row.id, 
                      :approved_flag => true,
                      :approved_by => row.approved_by)
        end
      end
    else
      @roles.each do |row|
        @role = params["approved_flag_" + row.id.to_s()]

        if(@role != nil && !row.used)
          Role.delete(row.id)
        else
          flash[:notice] = "The Role #{row.name} is assigned can not be deleted."
        end
      end
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/roles')
  end
end
