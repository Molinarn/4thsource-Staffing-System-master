class CandidatesProfilesController < ApplicationController

  def new

  end

  def index
    
    id = params[:candidate_id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate  = Candidate.find(params[:candidate_id])
      @error = @candidate.errors
    else
      @candidate = Candidate.find(current_candidate.id)
      @error  = current_candidate.errors
    end
    @total_candidate_profiles = @candidate.candidates_profiles
    #@total_candidate_profiles = CandidateProfile.all
  end

  def create
    #binding.pry
    @candidates_profile = CandidatesProfiles.new(params[:candidates_profiles])
    @candidates_profile.candidate_id = params[:candidate_id]
    @candidates_profile.save
    @error = @candidates_profile.errors.full_messages.to_sentence
    if !current_candidate.admin_flag.nil?
      #is admin
      redirect_to File.join('/candidates/', @candidates_profile.candidate_id.to_s, '/candidates_profiles')
    else
      #not an admin
      redirect_to File.join('/candidates/', current_candidate.id.to_s, '/candidates_profiles')
    end
  end

  def edit
    @candidates_profile  = CandidatesProfiles.find(params[:id])
    @total_candidate_profile_tags = @candidates_profile.candidate_profile_tags
    @candidate  = Candidate.find(params[:candidate_id])
    @total_projects = @candidate.projects
  end

  def update
    @candidate = current_candidate
    #binding.pry
    if request.post?
      @candidate = Candidate.find(params[:candidate_id])
      @profile = CandidatesProfiles.find(params[:candidates_profiles_id])
      @profile.update_attributes(params[:candidates_profiles])
      if @profile.save
        if !current_candidate.admin_flag.nil?
          #is admin
          redirect_to File.join('/candidates/', @candidate.id.to_s, '/candidates_profiles')
        else
          #not an admin
          redirect_to File.join('/candidates/', current_candidate.id.to_s, '/candidates_profiles')
        end
        flash[:success] = "Candidate Profile was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the candidate profile."
      end
    else
      @profile = CandidatesProfiles.find_by_id(params[:candidates_profiles_id])
      @error = @profile.errors
    end 
  end   

  def delete
    CandidatesProfiles.delete(params[:candidates_profiles_id])
    @candidate  = Candidate.find(params[:candidate_id])
    render :index
  end

  def update_tags
    CandidateProfileTag.where(:candidates_profiles_id => params[:id]).destroy_all

    if !params[:projects_tags_id].nil?
      params[:projects_tags_id].each do |t|
          @relation = CandidateProfileTag.new
          @relation.candidates_profiles_id =  params[:id]
          @relation.project_tags_id = t.to_i
          @relation.save
      end
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s, '/candidates_profiles/' + params[:id] + '/edit')
  end


  def docx
    # Generate docx file
    @candidate = Candidate.find(params[:candidate_id])
    @profSum = CandidateProfSummary.where("candidate_id = #{@candidate.id}")
    #binding.pry
    require 'docx_builder'

    file_path = "#{File.dirname(__FILE__)}/cvtemplate.xml"
    dir_path = "#{File.dirname(__FILE__)}/cvtemplate"

    report = DocxBuilder.new(file_path, dir_path).build do |template|
      template['candiname'] = @candidate.first_name
      template['candilast'] = @candidate.first_last_name
      template['candemail'] = @candidate.email
      template['company'] = @candidate.company
      template['positionheld'] = @candidate.position
      template['profsum'] = @profSum[0].summary
      template['workxpsum_company'] = ""
      template['workxpsum_position'] = ""
      template['workxpsum_jdate'] = ""
      template['workxpsum_fdate'] = ""
      template['techskills_os'] = ""
      template['techskills_db'] = ""
      #template['profsum'] = CandidateProfSummary.where(:candidate_id => params[:candidate_id])[0].summary
    
      if @candidate.candidate_education.count > 0
         @candidate.candidate_education.each do |education|
           #binding.pry
         end    
      end

    end 
    #binding.pry
    #send_file(report, :filename => 'CandidateResume_'+@candidate.first_name+'_'+@candidate.first_last_name+'.docx')
    response.headers['Content-disposition'] = 'attachment; filename=CandidateResume_'+@candidate.first_name+'_'+@candidate.first_last_name+'.docx'
    render :text => report, :content_type => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
  end

end


