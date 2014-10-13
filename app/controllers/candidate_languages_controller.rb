class CandidateLanguagesController < ApplicationController
  before_filter :authenticate
  
   def index
    
    id = params[:id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = current_candidate
      @error  = current_candidate.errors
    end  
    
    @total_languages = @candidate.candidate_languages
    @language = CandidateLanguage.new
   end
  def new
    
    id = params[:candidate_language]['idurl'] 
    unless params.blank?
    #id=params[:candidate_id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = current_candidate
      @error  = current_candidate.errors
    end  
    @candidate_language = @candidate.candidate_languages.build(params[:candidate_language])
    language = Language.new 

     if (params[:language_notinlist])

          if(!params[:lang_name].empty?)
            language.name = params[:lang_name]
            if (language.name.size > 50)
              flash[:notice] = "Language name could not be more than 50 characters"
              language = nil
            else
              language.save
            end
          else
            flash[:notice] = "Please provide a valid language name"
            language = nil
          end

     elsif params[:language_id].nil?
         flash[:notice] = "If language is not in the list, add it manually."
         @language = CandidateLanguage.new
         language = nil
       else
         language = Language.find(params[:language_id])
       end
       
     
     end
     @candidate_language.language = language
    if (language != nil )
      if @candidate_language.save
        flash[:success] = "languages was saved successfully."
      else
        language.destroy
        flash[:notice] = "An error occurred while the system save the languages#{@candidate_language.errors.as_json}"
      end
    end 
    redirect_to request.referer 
  end
  
  def destroy
    CandidateLanguage.find(params[:candidate_language]).destroy
    redirect_to request.referer
  end

  def edit
    id = params[:id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = current_candidate
      @error  = current_candidate.errors
    end
    @candidate_language_id = params[:candidate_language]
    @language_name_selected = params[:language_name]
    

    if request.post?
      @language = CandidateLanguage.find(params[:candidate_language])
      @language.update_attributes(params[:language])
      if @language.save
        flash[:success] = "Language was saved successfully."
        @projects_items = @candidate.projects
        redirect_to File.join('/candidates/', @candidate.id.to_s(), '/resume/languages')
      else
        flash[:notice] = "An error occurred while the system save the language."
      end
    else
      @language = CandidateLanguage.find(params[:candidate_language])
      @error = @language.errors
    end
  end
end