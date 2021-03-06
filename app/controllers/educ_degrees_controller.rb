class EducDegreesController < ApplicationController
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

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degrees')
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

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degrees')
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

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degrees')
  end

  def action

    puts "\neduc_degrees#action".green

    params[:table].each do |p|
      puts "#{p}".cyan
    end

    @degree = params["Selected_ID"]
    degree = current_candidate
 
    #binding.pry

    if request.post?

      if params[:update_button] != nil
          @approved_by = current_candidate.first_name + " " +
                         current_candidate.middle_name + " " +
                         current_candidate.first_last_name + " " +
                         current_candidate.second_last_name
    
         if params[:approved_flag_all]
              
            puts "\n#:approved_flag_all".magenta
            
            params[:table].each do |p|              
           
              p.each do |pt|
                puts "#{pt}".blue
              end
           
              educDegree = EducDegree.find(p.first)

              educDegree.approved_flag = true
              educDegree.approved_by = @approved_by
              educDegree.save
              
            end
         else
                      
           params[:table].each do |p|
            
             p.each do |pt|
                puts "#{pt}".blue
             end
             
             puts "\n#{p.second}".magenta
            
             educDegree = EducDegree.find(p.first)
            
             if p.second == 'valtrue'
               
               educDegree.approved_flag = true
               educDegree.approved_by = @approved_by
               educDegree.save
               
             else
               
               educDegree.approved_flag = false
               educDegree.approved_by = ''
               educDegree.save
               
             end
           end
            
         end
       
        #for str in @degree.split(":")

          #degree_value = EducDegree.find(str.split(",")[0])

          #if degree_value.approved_flag.to_s != str.split(",")[1]

            #EducDegree.update(str.split(",")[0],
                              #:approved_flag => str.split(",")[1],
                              #:approved_by => @approved_by)
          #end
        #end
      else
        if params[:delete_button] != nil
                    
          if params[:approved_flag_all]
            
            puts "\n#:approved_flag_all".magenta
            
            params[:table].each do |p|              
           
              educDegree = EducDegree.find(p.first)
              
              if educDegree.used
                #flash.now[:notice] = "The Education Degree #{educDegree.name} is assigned can not be deleted."
              else
                #EducDegree.delete(educDegree.id)
                educDegree.destroy
              end
            end
          else
                    
            params[:table].each do |p|
              
              puts "\n#{p.second}".magenta
              
              if p.second == 'valtrue'
              
                educDegree = EducDegree.find(p.first)
                
                if educDegree.used
                  #flash.now[:notice] = "The Education Degree #{educDegree.name} is assigned can not be deleted."
                else
                  #EducDegree.delete(educDegree.id)
                  educDegree.destroy
                end
              end
            end
          end
        
          #for param in params

            #if param[0].include?"approved_flag_"
              
              #puts "\n#{param[0].index("approved_flag_")}".yellow
              
              #if param[0].index("approved_flag_") >= 0
                           
                #param.each do |p|
                  #puts "\nparam_#{p}".magenta
                #end
                
                #educDegree = EducDegree.find(param[1])
                #if educDegree.used
                  #flash[:notice] = "The Education Degree #{educDegree.name} is assigned can not be deleted."
                #else
                  #EducDegree.delete(educDegree.id)
                #end
              #end
            #end
          #end
        end
      end
     
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/education_degrees')
    
  end

end
