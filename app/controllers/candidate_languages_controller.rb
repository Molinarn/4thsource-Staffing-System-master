class CandidateLanguagesController < ApplicationController
  before_filter :authenticate
  
   def index

     puts "\ncandidate_languages#index".green

    id = params[:id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = current_candidate
      @error  = current_candidate.errors
    end

    #@candidate_language = @candidate.candidate_languages
    
    #@total_languages = @candidate_language.languages
    @candidate_language = @candidate.candidate_languages
    #@total_languages = @candidate.candidate_languages
    @language = CandidateLanguage.new
    
   end

  def new

    @flag = true
    
    puts "\ncandidate_languages#new".green

    params.each do |p|
      puts "#{p}".cyan
    end

    #id = params[:candidate_id]

    id = params[:candidate_language][:idurl]
    #unless params.blank?
    #id=params[:candidate_id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = current_candidate
      @error  = current_candidate.errors
    end
    #@candidate_language = @candidate.candidate_languages.build(params[:candidate_language])

    puts "\n@candidate.id: #{@candidate.id}".magenta

    language = Language.new
    #@candidate_language = @candidate.candidate_languages.new

    #if !params[:language_notinlist]
      #@language = Language.find(params[:candidate_language][:id]).name
    #else
     # @language = params[:lang_name]
    #end

    #if @candidate.candidate_languages.nil? || @candidate.candidate_languages.count <= 0 
      
       #@candidate_language = @candidate.candidate_languages.new(:level_id => params[:candidate_language][:level_id])
       #@candidate_language.save

    #else
      
      #@candidate_language = @candidate.candidate_languages
      #@candidate.update_attributes(params[:candidate_language][:level_id])
      
      #@candidate_language.each do |cl|
        #puts "#{cl}".cyan
      #end
      
    #end

    @filter_languages = FilterLanguage.where("language_id = ?",params[:candidate_language][:id])
    if !@filter_languages.nil?
      @candidate_languages = @filter_languages.find_all_by_candidate_language_id(@candidate.candidate_languages.select("id"))
    else
      @candidate_languages = {}  
    end
    
    #If add manually is selected and the language is not in the list
    if params[:language_notinlist] && Language.where("name = ?",params[:lang_name]).count == 0

      puts "\nparams[:language_notinlist]: #{params[:language_notinlist]}".magenta
      puts "\nname = ?,params[:lang_name]: #{Language.where("name = ?",params[:lang_name]).count}".magenta

      #if !params[:lang_name].empty?
        language.name = params[:lang_name]
        if language.name.size > 50
          flash[:notice] = "Language name could not be more than 50 characters"
          language = nil
        else
          language.save
        end
      #else
       # flash[:notice] = "Please provide a valid language name"
       # language = nil
      #end

    #elsif params[:id].nil?
      #flash[:notice] = "If language is not in the list, add it manually."
      #@language = CandidateLanguage.new
      #language = nil

    # If the selected language from comboBox already exist for this candidate_languages
    #elsif !@candidate_language.nil? && FilterLanguage.where("language_id = ?",params[:candidate_language][:id]).where("candidate_language_id = ?",@candidate_language.id).count > 0
    #elsif @filter_language
      #flash[:notice] = "Language already assigned, please select a different language"
      #language = nil
    elsif params[:language_notinlist] && Language.where("name = ?",params[:lang_name]).count > 0
      flash[:notice] = "Language is currently assigned to this candidate"
      language = nil
    elsif !params[:language_notinlist] && @candidate_languages.count > 0
      flash[:notice] = "Language is currently assigned to this candidate"
      language = nil
    else
      language = Language.find(params[:candidate_language][:id])
    end

    if language != nil

      #@candidate_language = @candidate.candidate_languages.build(params[:candidate_language])
      #@candidate_language.language = language
      
      @candidate_language = @candidate.candidate_languages.new(:level_id => params[:candidate_language][:level_id]) 
      @candidate_language.save
      
      @candidate.candidate_languages.each do |cl|
        puts "#{cl.id}".cyan
      end

      @filter_language = @candidate_language.filter_languages.new(:language_id => language.id)

      #if @candidate_language.save
      if @filter_language.save
        
        @candidate_language.filter_languages.each do |f|
          puts "#{f}".cyan
        end
        
        flash[:success] = "languages was saved successfully."
      else
        language.destroy
        flash[:notice] = "An error occurred while the system save the languages#{@candidate_language.errors.as_json}"
      end

      #redirect_to request.referer
      
    #else
      #redirect_to request.referer
    end
      redirect_to request.referer
      
    #else
     # render :index
    #end
    
    #redirect_to request.referer
    
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
        redirect_to File.join('/candidates/', @candidate.id.to_s, '/resume/languages')
      else
        flash[:notice] = "An error occurred while the system save the language."
      end
    else
      @language = CandidateLanguage.find(params[:candidate_language])
      @error = @language.errors
    end
  end
end