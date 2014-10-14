require 'ProfileBuilder2'

class CandidatesProfilesController < ApplicationController
  # GET /candidates_profiles
  # GET /candidates_profiles.json  
  def index

    puts "\ncandidates_profile#index".green

    id = current_candidate.id

    puts "\ncurrent_candidate.id:  #{id}".cyan

    id = params[:id] unless (params[:id] == nil)

    puts "\nparams[:id]:  #{id}".cyan

    @candidate = Candidate.find_by_id(id)

    puts "\n@candidate.id: #{@candidate.id}".magenta

    @candidates_profile = @candidate.candidates_profiles.paginate(:page => params[:page], :per_page => 20)
    #@candidates_profile = @candidate.candidates_profiles.find(params[:candidates_profile_id])

    #@candidates_profile = CandidatesProfile.find_by :candidate_id => id

    puts "\n@candidates_profile.id: #{@candidates_profile.id}".magenta

  end

  def IsValueInFilter(hasfilterputs, value, filter)
    @include = false
    if hasfilterputs
      if filter.include? "{##{value}#}"
        @include = true
      end
    else
      @include = true
    end 
    @include   
  end

  def getCheckedValue(item, candprof)  
    @hasFilter = false
    @hasfilter = true if (candprof.profiledata != "")
    if IsValueInFilter(@hasfilter, item, candprof.profiledata)
      "item-checked='true'"
    else
      "item-checked='false'"
      #candprof.profiledata
    end
  end


  # GET /candidates_profiles/1
  # GET /candidates_profiles/1.json
  def show

    puts "\ncandidates_profile#show".green

    @candidates_profile = CandidatesProfile.find_by_id(params[:candidates_profile_id])
    #@candidate = Candidate.find_by_id(@candidates_profile.candidate_id)   
    @builder = ProfileBuilder2.new
    @builder.filter = @candidates_profile.profiledata
    @builder.nameprof = @candidates_profile.name
    @builder.summaryprof = @candidates_profile.summary
    @builder.candidate_id = @candidates_profile.candidate_id
    @filename = @builder.build
    File.open(@filename, 'rb') do |f|
      send_data f.read, :type => "application/msword", :disposition => "inline", :filename => "profile" + Time.now().to_s + ".docx"
    end    
  end

  # GET /candidates_profiles/new
  # GET /candidates_profiles/new.json
  def new

    puts "\ncandidates_profile#new".green

    @candidate = Candidate.find_by_id(params[:candidate_id])
    @candidates_profile = CandidatesProfile.new
  end

  # GET /candidates_profiles/1
  # GET /candidates_profiles/1.json
  def editprofile

    puts "\ncandidates_profile#edit".green

    @candidates_profile = CandidatesProfile.find_by_id(params[:candidates_profile_id])
    @candidate = Candidate.find_by_id(@candidates_profile.candidate_id)  
    render :edit 
  end

  # POST /candidates_profiles
  # POST /candidates_profiles.json
  def create

    puts "\ncandidates_profile#create".green

    @candidates_profile = CandidatesProfile.new(params[:candidates_profile])

    respond_to do |format|
      if @candidates_profile.save
        format.html { redirect_to @candidates_profile, :notice => 'Candidates profile was successfully created.' }
        format.json { render json = @candidates_profile, status = :created, location = @candidates_profile }
      else
        format.html { render action = "new" }
        format.json { render json = @candidates_profile.errors, status = :unprocessable_entity }
      end
    end
  end

  def save
    @candidates_profile = CandidatesProfile.new
    @candidates_profile.candidate_id = params[:candidate_id]
    @candidates_profile.name = params[:name]
    @candidates_profile.summary = params[:summary]
    @candidates_profile.profiledata = params[:profiledata]
    if @candidates_profile.save
      @candidate = Candidate.find_by_id(@candidates_profile.candidate_id)   
      @candidates_profile = @candidate.candidates_profiles.paginate(:page => params[:page], :per_page => 20)
      redirect_to action:"index", id = @candidates_profile.candidate_id
    else
      render text = "Error while saving profile " + @candidates_profile.errors.to_xml
    end
  end

  # PUT /candidates_profiles/1
  # PUT /candidates_profiles/1.json
  def update
    @candidates_profile = CandidatesProfile.find(params[:id])

    @candidates_profile.name = params[:name]
    @candidates_profile.summary = params[:summary]
    @candidates_profile.profiledata = params[:profiledata]
    if @candidates_profile.save
      @candidate = Candidate.find_by_id(@candidates_profile.candidate_id)   
      @candidates_profile = @candidate.candidates_profiles.paginate(:page => params[:page], :per_page => 20)
      redirect_to action:"index", id = @candidates_profile.candidate_id
    else
      render text = "Error while saving profile " + @candidates_profile.errors.to_xml
    end
  end

  # DELETE /candidates_profiles/1
  # DELETE /candidates_profiles/1.json
  def delete
    @candidates_profile = CandidatesProfile.find(params[:candidates_profile_id])
    id = @candidates_profile.candidate_id
    @candidates_profile.destroy
    redirect_to action:"index", id = id
  end

  def admin
    #binding.pry
    @candidate = Candidate.find_by_id(params[:candidate_id])


    render "candidate_profiles/admin"
  end

  #Estoy trabajando en este clone, el original es el de jobs
  def createjob

    id = current_candidate.id
    strTags = ""
    experience = ""
    
    query = ProjectsTag.find_by_sql(["SELECT DISTINCT cp.profiledata as pd
        ,DATEDIFF(pt.date_out,pt.date_in)/365 AS exp
        FROM projects_tags pt
        JOIN projects_roles pr ON pt.projects_role_id = pr.id
        JOIN projects p ON pr.project_id = p.id
        JOIN candidates c ON p.candidate_id = c.id
        JOIN candidates_profiles cp ON c.id = cp.candidate_id
        WHERE c.id = ?",id])
         
     
    candidateProfileId = params[:candidates_profile_id]
   
    arrayTags = splitString(query.first.pd)

    newJobId = createJob
    arrayTags.each do |tagId|
      newJob = insertJobMatch(newJobId,tagId,query.first.exp)
    end

    redirect_to "/staff/#{id}/jobs/#{newJobId}/edit"
  end 


  def createJob
    newJob = Job.new
    newJob.title = "Job Clone"
    newJob.description = "Job Clone "
    newJob.other_requirements = nil
    newJob.admin_users_id = nil
    newJob.id_requester = nil
    newJob.id_status = 1
    newJob.id_parent = nil
    newJob.save
    last_record_saved_id=Job.last.id
    logger.debug "New Job created: " + last_record_saved_id.to_s
    return last_record_saved_id
  end


  def insertJobMatch(jobId,tagId,time)
    newJM = JobMatch.new
    newJM.job_id = jobId
    newJM.tag_id = tagId
    newJM.time_required = time
    newJM.id_technologie = insertFramework(tagId)
    newJM.save
  end

  #Si el tag en la tabla de tags es type_tag=3 quiere decir que se trata de una "Tecnologia" y entonces
  #puede tener un framework asociado en la tabla technologies. Donde Lang_id es el id de la "Tecnologia"
  def insertFramework(tagId)

    tag = Tag.find_by_id(tagId)
    if tag!=nil
      if tag.type_tag = 3 #Its a Platform, so, could have a technologie
        framework = Array.new
        framework << Technology.find_by_lang_id(tagId)
        if framework[0]!=nil
          return framework[0].id
        else
          return nil
        end
      end
    end      
  end

  #Input example "{#tag:66/13/15#}{#undefined:undefined#}{#role:66/13#}{#project:66#}{#tag:66/13/24#}{#undefined:undefined#}{#tech:66/13/4/6#}{#tag:66/13/224#}"
  def splitString(strTags)
    trace = false
    strAuxTags = "";
    strTagPartial = "";
    arrayTagsLocal = Array.new

    
    while strTags.include?"{#tag:"
        initPos = strTags.index('{#tag:')
        if initPos>0
          strTags[0..initPos-1] = ""
          initPos = 0
        end
        endPos = strTags.index('#}')+2
        strTagPartial = strTags[initPos,endPos]
        strTags[0..endPos] = ""
        arrayTagsLocal.push(splitTag(strTagPartial))
        if(trace)
          logger.debug "====strTags:" + strTags.to_s
          logger.debug "====strTagPartial:" + strTagPartial.to_s
          logger.debug "====strTags:" + strTags.to_s
        end
    end
    return arrayTagsLocal
  end

  #Input {#tag:66/13/5#}
  #Output 5 
  #This method will receive input tag as JSON and the output will be the tag id 
  def splitTag(strTag)
    initPos = strTag.rindex('/')+1
    endPos = strTag.length-3
    tag = strTag[initPos..endPos]
    return tag
  end


end
