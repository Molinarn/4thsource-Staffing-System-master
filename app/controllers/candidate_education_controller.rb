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
    puts "\n@education.id: #{@education.id}}".cyan

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
    #Creates a new education for a candidate

    puts "\ncandidate_education#create".green

    id=params[:id] unless params.blank?
    if params[:education_educ_degree_id_new] == ""
      if id.nil?
        @education = current_candidate.candidate_education.build(params[:education])
      else
        wall_candidate=Candidate.find(id)
        @education=wall_candidate.candidate_education.build(params[:education])
      end
      @education.save
    else
      #Creates a new education degree
      degree = params[:education_educ_degree_id_new]
      @cat_degree_rows = EducDegree.where("name = ?", degree)

      if @cat_degree_rows.length > 0
        flash[:notice] = "The Education Degree Already Exists"
      else

        puts "\nCreate EducDegree".cyan

        #cat_degree = EducDegree.new(:name => degree, :description => degree, :approved_flag => false)
        #cat_degree.save!
      
        @education = current_candidate.candidate_education.build(params[:education])
        #@education.educ_degree_id = cat_degree.id
        #cat_degree.candidate_education_id = @education.id
        @education.save
        cat_degree = @education.educ_degrees.new(:name => degree, :description => degree, :approved_flag => false)
        cat_degree.save
      end
    end
    if @candidate.nil?
      @candidate = Candidate.find(params[:id])
       if @candidate.candidate_languages.empty?
                redirect_to :controller=>'candidate_languages', :action => 'index', :candidate_id => @candidate.id, :method => 'get'
               else
                redirect_to File.join('/candidates/',id, '/resume/education')
      end
      else
        redirect_to File.join('/candidates/',id, '/resume/education')
     end

    
  end

  def edit

    puts "\ncandidate_education#edit".green

    puts "\n:candidate_education_id: #{params[:candidate_education_id]}".magenta

    @e = CandidateEducation.find_by_id(params[:candidate_education_id])

    @e.update_attributes(:id => params[:candidate_education_id],
                                :candidate_id => params[:id],
                                :title => params[:title],
                                #:degree => params[:degree],
                                :university => params[:university],
                                :date_in => params[:date_in],
                                :date_out => params[:date_out])

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

    @candidate_id = params[:id]

    params[:education].each do |p|
      puts "#{p}".cyan
    end

    @candidate_education = CandidateEducation.new(params[:education])

    @candidate_education.candidate_id = @candidate_id

    puts "\n@candidate_education.id #{@candidate_education.id}".red

    @e = CandidateEducation.find_by_id(@candidate_education.id)
    @e.update_attributes(:id => @candidate_education.id,
                         :candidate_id => @candidate_id,
                         :title => @candidate_education.title,
                         :university => @candidate_education.university,
                         :date_in => @candidate_education.date_in,
                         :date_out => @candidate_education.date_out)

    newDegree = params[:education_educ_degree_id_new]

    newDegree.each do |d|
      puts "#{d}".cyan
    end

    actualDegree = EducDegree.find_by_candidate_education_id(@e.id)

    if newDegree != actualDegree.name
        actualDegree.update_attributes(:name => newDegree)
    end

    #if temp.nil?

      #puts ["\n:education_educ_degree_id_new.nil?".yellow, "#{temp.nil?}".red]

    #else

      #Get all the registers from the name field of the educ_degrees table

      #degree = temp



      #puts "\nelse_education_educ_degree_id_new.nil? > degree: #{degree.nil?}".blue

      #Returns all the degrees that are already registered
      #@cat_degree_rows = EducDegree.where("name = ?", degree)

      #if @cat_degree_rows.length > 0

        #puts "\n@cat_degree_rows.length: #{@cat_degree_rows.length}".yellow

        #flash[:notice] = "The Education Degree Already Exists"

      #else
        #cat_degree = EducDegree.new(:name => degree, :description => degree, :approved_flag => false)

        #cat_degree = @e.educ_degrees.new(:name => temp)

        #puts "\ncat_degree.id: #{cat_degree.id}"
        #puts "\ncat_degree.name: #{cat_degree.name}"

        #cat_degree.save!

      #end
    #end

    puts "\ncandidate_id: #{@e.candidate_id}".magenta

    redirect_to File.join('/candidates/', @e.candidate_id.to_s, '/resume/education')

  end
end