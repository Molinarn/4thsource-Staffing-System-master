class CandidateEducationController < ApplicationController  #
  def index
    id = params[:id] unless params.blank?
    if id.nil?
      @education = current_candidate.candidate_education
    else
      wall_candidate=Candidate.find(id)
      @education=wall_candidate.candidate_education
    end

    #if !current_candidate.admin_flag.nil?
    #  Rails.logger.info("ADMIN FLAG>> IM ADMIN!!")
      @candidate = Candidate.find(id)
      @error = @candidate.errors
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
        cat_degree = EducDegree.new(:name => degree, :description => degree, :approved_flag => false)
        cat_degree.save!
      
        @education = current_candidate.candidate_education.build(params[:education])
        @education.educ_degree_id = cat_degree.id
        @education.save
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
    @candidate_id=params[:candidate_id]
    @e = CandidateEducation.new(:id => params[:id], 
                                :title => params[:title], 
                                :educ_degree_id => params[:educ_degree_id],
                                :university => params[:university],
                                :date_in => params[:date_in],
                                :date_out => params[:date_out])
  end

  def destroy
    CandidateEducation.delete(params[:id])
    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end

  def update
    @education = CandidateEducation.new(params[:education])

    if params[:education_educ_degree_id_new] == ""
      CandidateEducation.update(@education.id, 
                                :title => @education.title, 
                                :educ_degree_id => @education.educ_degree_id,
                                :university => @education.university,
                                :date_in => @education.date_in,
                                :date_out => @education.date_out)
    else
      degree = params[:education_educ_degree_id_new]
      @cat_degree_rows = EducDegree.where("name = ?", degree)

      if @cat_degree_rows.length > 0
        flash[:notice] = "The Education Degree Already Exists"

      else
        cat_degree = EducDegree.new(:name => degree, :description => degree, :approved_flag => false)
        cat_degree.save!
      
        CandidateEducation.update(@education.id, 
                                  :title => @education.title, 
                                  :educ_degree_id => cat_degree.id,
                                  :university => @education.university,
                                  :date_in => @education.date_in,
                                  :date_out => @education.date_out)
      end
    end

    redirect_to File.join('/candidates/', params[:candidate_id], '/resume/education')
  end
end