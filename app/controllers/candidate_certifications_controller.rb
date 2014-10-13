class CandidateCertificationsController < ApplicationController
  def index
    logger.debug "*******************index**********************"
    id = params[:candidate_id] unless params.blank?
    Rails.logger.info("CANDIDATES ID #{id}");
    #if !current_candidate.admin_flag.nil?
    if id.nil?
      @candidate = Candidate.find(current_candidate.id)
      @error  = current_candidate.errors
    else
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    end
    #@candidate  = Candidate.find(params[:candidate_id])
    #@error = @candidate.errors
    @total_certifications = @candidate.candidate_certifications
    #@certification = @candidate.resume.certifications.new
    #@certification  = Certification.new
  end

  def new
  	logger.debug "PASANDO POR NEW"
    @candidate_id=params[:candidate_id]
    logger.debug "CANDIDATES ID TO CREATE A NEW CERTIFICATION = #{@candidate_id}"
  end

  def destroy
    CandidateCertification.find(params[:id]).destroy  
    redirect_to request.referer
  end

  def create
    id = params[:candidate_id] unless params.blank?
    #Recover candidates data
    if id.nil?
      @candidate=Candidate.find(current_candidate.id)
      @error=@candidate.errors
    else
      @candidate=Candidate.find(id);
      @error=current_candidate.errors
    end

    #if !current_candidate.admin_flag.nil?
    #  @candidate = Candidate.find(id)
    #  @error = @candidate.errors
    #else
    #  @candidate = Candidate.find(current_candidate)
    #  @error  = current_candidate.errors
    #end
    #@candidate = Candidate.find(current_candidate)

    #puts "json params is:"
    #puts  params.to_json 
    certification = Certification.new

    #Creating new certification
    if params[:certification_chBNotInList]
      if(not params[:certification][:name].empty?)
        if Certification.find_by_name(params[:certification][:name])==nil
          certification.name = params[:certification][:name]   
        else 
          flash[:notice] = "The certification already exist, please search it again in the list."
          redirect_to File.join('/candidates/', @candidate.id.to_s(), '/candidate_certifications')
          return
        end
      else
        flash[:notice] = "Please provide a valid Certification name"
        redirect_to File.join('/candidates/', @candidate.id.to_s(), '/candidate_certifications')
        return
      end
    else
      if params[:certification][:selectName].nil?
        flash[:notice]="Invalid argument for a certification. Please choose a valid certification o create a new one"
        redirect_to File.join('/candidates/', @candidate.id.to_s(), '/candidate_certifications')
        return
      else
        certification = Certification.find(params[:certification][:selectName])
      end
    end

    #Assigning certification to candidate and saving
    if  !certification.nil?
      #c=CandidateCertification.find_by_certification_id(certification.id)
      c=CandidateCertification.where("candidate_id = ? AND certification_id = ?",@candidate.id,certification.id)
      logger.debug "CCCC >>>#{c.inspect}"
      if (c.length==0)
        @candidate_certification = @candidate.candidate_certifications.build(params[:candidate_certification]) 
        @candidate_certification.certification = certification
      else
        flash[:notice] = "You already have this certification in your list"
        redirect_to File.join('/candidates/', @candidate.id.to_s(), '/candidate_certifications')
        return
      end

      if(@candidate_certification.save)
        flash[:success] = "Certification was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the certification #{@candidate_language.errors.as_json}"
      end
    else 
      flash[:notice] = "Database error. Could not find the certification selected"
    end
    #redirect_to request.referer
    #if !current_candidate.admin_flag.nil?
      #is admin
      redirect_to File.join('/candidates/', @candidate.id.to_s(), '/candidate_certifications')
    #else
      #not an admin
     # redirect_to File.join('/candidates/', @candidate.id.to_s(), '/candidate_certifications')
    #end
    
  end
end


