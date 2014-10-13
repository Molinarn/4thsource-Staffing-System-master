class LanguagesController < ApplicationController
  def index
    @languages = Language.all
    set_wall_candidate(nil)
    set_my_wall(nil)
  end

  def new
    
  end

  def create
  
    @language = Language.new(params[:language])

    @cat_language_rows = Language.where("name = ?", @language.name)
    
    if @language.name.blank? == true
       flash[:notice] = "Invalid language name." 
    end
    
    if @cat_language_rows.length > 0
      flash[:notice] = "The Language Already Exists"

    else
      @language.approved_flag = true
      @language.approved_by = current_candidate.first_name + " " + 
                              current_candidate.middle_name + " " + 
                              current_candidate.first_last_name + " " + 
                              current_candidate.second_last_name
      @language.save
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/languages')
  end

  def action
    @languages = Language.all

    if(params[:update_button] != nil)
      @languages.each do |row|
        @language = params["approved_flag_" + row.id.to_s()]
        row.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name

        if(@language == nil)
          Language.update(row.id, 
                          :approved_flag => false,
                          :approved_by => row.approved_by)
        else
          Language.update(row.id, 
                          :approved_flag => true,
                          :approved_by => row.approved_by)
        end
      end
    else
      if(params[:delete_button] != nil)

        for param in params
          if(param[0].include?"approved_flag_")
            if(param[0].index("approved_flag_") >= 0)
              language = Language.find(param[1])
              if (language.used)
                flash[:notice] = "The Language #{language.name} is assigned can not be deleted."
              else
                Language.delete(language.id)
              end
            end
          end
        end
      end 
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/languages')
  end
end
