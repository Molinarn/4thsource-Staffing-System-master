class CandidateEducationController < ApplicationController  #
  def index

    puts "\ncandidate_education#index".green

    id = params[:id] unless params.blank?
    #id = params[:candidate_id] unless params.blank?

    puts "\nid: #{id}".red

    if id.nil?

      puts "\nid.nil? > true".red

      #@candidate = Candidate.find(id)
      #@education = @candidate.candidate_education
      @education = current_candidate.candidate_education

    else

      puts "\nid.nil? > false".red

      wall_candidate=Candidate.find(id)
      @education=wall_candidate.candidate_education

    end

    #Both of the above clauses returns @education as a hash instead of as an element

    @candidate = Candidate.find(id)
    @error = @candidate.errors


    #@eduCount = CandidateEducation.where(:candidate_id => id).count
    #puts "\neduCount: #{@eduCount}".blue

    #This action gets the right instance of the candidate_education object
    #@education = CandidateEducation.find_by_candidate_id(id)
    #@education = current_candidate.candidate_education

    #Not the same id
    @education.each do |edu|
      puts "#{edu.id}".cyan
    end
    

    #@degree = EducDegree.find_by_candidate_education_id(@education.id)

    #puts "\n@degree: #{@degree.name}}".cyan

    #if !current_candidate.admin_flag.nil?
    #  Rails.logger.info("ADMIN FLAG>> IM ADMIN!!")
      #@candidate = Candidate.find(id)
      #@error = @candidate.errors

    #else
    #  Rails.logger.info("NO FLAG :( IM A MORTAL")
    #  @candidate = Candidate.find(current_candidate.id)
    #  @error  = current_candidate.errors
    #end
    #Rails.logger.info("<<<CANDIDATE>>> #{@candidate.inspect}")
  end

  def new
    
  end

  def create
    
    puts "\ncandidate_education#create".green
    
    @candidate = Candidate.find(params[:id])
    puts "\n@candidate: #{@candidate.id}".cyan
    
    #Creates a new education for a candidate    

    params.each do |p|
      puts "#{p}".magenta
    end

    #id=params[:id] unless params.blank?
    if params[:education_educ_degree_id_new] == ""
      
       #puts "\nparams[:education_educ_degree_id_new] == ''".cyan
      
      #if id.nil?
      if params[:education][:educ_degree_id].nil?
        
        #puts "\nparams[:education][:educ_degree_id].nil?: #{params[:education][:educ_degree_id].nil?}".red
        
        flash[:notice] = "Please select or add a degree"
        @education = nil
        #render :new
        #@education = current_candidate.candidate_education.build(params[:education])
      else
        
        #puts "\nparams[:education][:educ_degree_id]: #{params[:education][:educ_degree_id]}".cyan

        @cat_degree_rows = @candidate.candidate_education.where("educ_degree_id = ?", params[:education][:educ_degree_id])

        if @cat_degree_rows.count > 0
          flash[:notice] = "Education Degree Already Assigned"
          #cat_degree = @cat_degree_rows.first
          #@education.educ_degree_id = cat_degree.id
          #@education.save
          @education = nil
        else

          @education = @candidate.candidate_education.new(params[:education]) 
          @education.save
          
        end
      end
      #@education.save
    else
      #Creates a new education degree
      
      #puts "\nparams[:education_educ_degree_id_new]: #{params[:education_educ_degree_id_new]}".magenta
      
      degree_name = params[:education_educ_degree_id_new]
      degree = EducDegree.find_by_name(degree_name)
      
      if !degree.nil?
        @cat_degree_rows = @candidate.candidate_education.where("educ_degree_id = ?", degree.id)  
      else
        @cat_degree_rows = {}
      end
      
      if @cat_degree_rows.count > 0
        flash[:notice] = "Education Degree Already Assigned"
        @education = nil
      else

        puts "\nCreate EducDegree".cyan

        @education = @candidate.candidate_education.new(params[:education])
    
        cat_degree = EducDegree.new(:name => degree_name, :description => degree_name, :approved_flag => false)
        cat_degree.save
        @education.educ_degree_id = cat_degree.id
        @education.save
        #redirect_to File.join('/candidates/',id, '/resume/education')
      end
    end
    
    if @education == nil
       render :new
    else
       redirect_to File.join("/candidates/","#{@candidate.id}","/resume/education")
    end 
  end

  def edit

    puts "\ncandidate_education#edit".green

    puts "\n:candidate_education_id: #{params[:candidate_education_id]}".magenta

    @e = CandidateEducation.find(params[:candidate_education_id])

    #@e.update_attributes(:id => params[:candidate_education_id],
                                #:candidate_id => params[:id],
                                #:title => params[:title],
                                #:degree => params[:degree],
                                #:university => params[:university],
                                #:date_in => params[:date_in],
                                #:date_out => params[:date_out])

    puts "\n@e.id #{@e.id}".red

    #@degrees = @e.educ_degrees

    #@degrees.each do |d|
      #puts "#{d.name}".cyan
    #end

    #puts "degrees.nil?: #{@degrees.nil?}".red

  end

  def addDegree

    puts "\ncandidate_education#addDegree".green

    @e = CandidateEducation.find_by_id(params[:candidate_education_id])
    @degrees = @e.educ_degrees

    newDegrees = params[:education_educ_degree_id_new]

    if !newDegrees.nil?

      filteredDegrees = EducDegree.where("name != ?", degrees)
      filteredDegrees.each do |d|
        @e.educ_degrees.new(:name => d.name)
      end

      @degrees = @e.educ_degrees

    end

  end

  def destroy

    puts "\ncandidate_education#destroy".green
    @candidate_education = CandidateEducation.find(params[:id])
    #CandidateEducation.delete(params[:id])

    @candidate_education.destroy

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/resume/education')
  end

  def update

    puts "\ncandidate_education#update".green

    @candidate = Candidate.find(params[:id])
    @flag = true

    params.each do |p|
      puts "#{p}".magenta
    end

    puts "\n#{params[:education][:id]}".yellow

    @e = @candidate.candidate_education.find(params[:education][:id])
    
    puts "\n@education: #{@e.id}".yellow
    
    if params[:education_educ_degree_id_new] == ""

      if params[:education][:educ_degree_id].nil?

         flash[:notice] = "Please select or add a degree"
         @flag = false 
   
      else

         @cat_degree_rows = @candidate.candidate_education.where("educ_degree_id = ?", params[:education][:educ_degree_id])

         if @cat_degree_rows.count > 0 && @e.educ_degree_id != params[:education][:educ_degree_id] 
           flash[:notice] = "Education Degree Already Assigned"
           @flag = false 
  
         else
  
           @e.update_attributes(params[:education]) 
           @e.educ_degree_id = degree.id
           @e.save
          
         end
      end
      #@education.save
    else
      #Creates a new education degree
      
      #puts "\nparams[:education_educ_degree_id_new]: #{params[:education_educ_degree_id_new]}".magenta
      
      degree = EducDegree.find_by_name(params[:education_educ_degree_id_new])
      
      if !degree.nil?         
        @cat_degree_rows = @candidate.candidate_education.where("educ_degree_id = ?", degree.id)      
      else        
        @cat_degree_rows = {}       
      end
      
      puts "\ncount: #{@cat_degree_rows.count}".cyan
        
      if @cat_degree_rows.count > 0 && @e.educ_degree_id != degree.id
        
        flash[:notice] = "Education Degree Already Assigned"
        @flag = false
     
      elsif @cat_degree_rows.count > 0 && @e.educ_degree_id == degree.id
        @e.update_attributes(params[:education])
        @e.educ_degree_id = degree.id
        @e.save
          
      else

        @e.update_attributes(params[:education])
    
        cat_degree = EducDegree.new(:name => params[:education_educ_degree_id_new], :description => "Description for" + params[:education_educ_degree_id_new], :approved_flag => false)
        cat_degree.save
        @e.educ_degree_id = cat_degree.id
        @e.save
        #redirect_to File.join('/candidates/',id, '/resume/education')
      end
    end
    
    #if @e == nil
    if !@flag 
       render :edit
    else
       redirect_to File.join("/candidates/","#{@candidate.id}","/resume/education")
    end     
  end
end