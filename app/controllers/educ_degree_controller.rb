class EducDegreeController < ApplicationController
  def index

    puts "\neduc_degree#index".green

    @degrees = EducDegree.all
    set_wall_candidate(nil)
    set_my_wall(nil)
  end

  def new
  end

  def create

    puts "\neduc_degree#create".green

    @degree = EducDegree.new(params[:degree])

    @cat_degree_rows = EducDegree.where("name = ?", @degree.name)

    if @degree.name.blank?
       flash[:notice] = "Invalid education degree name." 
    end

    if @cat_degree_rows.length > 0
      flash[:notice] = "The Education Degree Already Exists"

    else
      @degree.approved_flag = true
      @degree.approved_by = current_candidate.first_name + " " + 
                            current_candidate.middle_name + " " + 
                            current_candidate.first_last_name + " " + 
                            current_candidate.second_last_name
      @degree.save
      flash[:notice] = "The Education Degree was saved successful!!"
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degree')
  end

  def edit

    puts "\neduc_degree#edit".green

    @d = EducDegree.new(:id => params[:id], 
                        :name => params[:name], 
                        :description => params[:description],
                        :approved_flag => params[:approved_flag])
  end

  def destroy
    @candidateEducations = CandidateEducation.where("educ_degree_id = ?", params[:id])

    if @candidateEducations.length > 0
      flash[:notice] = "This Education Degree is Associated to an Candidate Education, Cannot be Deleted"

    else
      EducDegree.delete(params[:id])
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degree')
  end

  def update

    puts "\neduc_degree#update".green

    @degree = EducDegree.new(params[:degree])

    @degree.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name
    
    @cat_degree_rows = EducDegree.where("name = ?", @degree.name)

    if @cat_degree_rows.length > 0
      flash[:notice] = "The Education Degree Already Exists"

    else
      EducDegree.update(@degree.id, 
                        :name => @degree.name, 
                        :description => @degree.description,
                        :approved_flag => @degree.approved_flag,
                        :approved_by => @degree.approved_by)
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degree')
  end

  def action
  
  
    @degree = params["Selected_ID"]
    degree = current_candidate
 
 binding.pry
 
    if params[:update_button] != nil
        @approved_by = current_candidate.first_name + " " + 
                       current_candidate.middle_name + " " + 
                       current_candidate.first_last_name + " " + 
                       current_candidate.second_last_name
      
      for str in @degree.split(":")

        degree_value = EducDegree.find(str.split(",")[0])
        
        if degree_value.approved_flag.to_s != str.split(",")[1]

          EducDegree.update(str.split(",")[0], 
                            :approved_flag => str.split(",")[1],
                            :approved_by => @approved_by)
        end
      end
    else
      if params[:delete_button] != nil
        for param in params
          if param[0].include?"approved_flag_"
            if param[0].index("approved_flag_") >= 0
              educDegree = EducDegree.find(param[1])
              if educDegree.used
                flash[:notice] = "The Education Degree #{educDegree.name} is assigned can not be deleted."
              else
                EducDegree.delete(educDegree.id)
              end
            end
          end
        end
      end
     
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degree')
  end

end
