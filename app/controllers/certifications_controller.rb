class CertificationsController < ApplicationController
  
  def index
   
    puts "\nCertification#index".green 
    
    @certifications = Certification.all
    set_my_wall(nil)
    set_wall_candidate(nil)
  
  end

  def new
    
  end

  def newOld
    if request.post?
      @certification = Certification.new(params[:certification])
      @cat_certification_rows = Certification.where("name = ?", @certification.name)
      if @cat_certification_rows.length > 0
        flash[:notice] = "The Certification already exists"
      else
        if params[:certification][:name].strip == ""
          flash[:notice] = "Name field is invalid."
        else
          @certification.approved_flag = true
          @certification.approved_by = current_candidate.first_name + " " + 
                                current_candidate.middle_name + " " + 
                                current_candidate.first_last_name + " " + 
                                current_candidate.second_last_name
          @certification.save
          @certifications = Certification.all
          redirect_to File.join('/staff/', current_candidate.id.to_s, '/certifications')
        end
      end
    else
      @certification = Certification.new
    end
  end

  def create
  
    @certification = Certification.new(params[:certification])

    @cat_certification_rows = Language.where("name = ?", @certification.name)
    
    if @certification.name.blank? == true
       flash[:notice] = "Invalid certification name." 
    end
    
    if @cat_certification_rows.length > 0
      flash[:notice] = "The Certification Already Exists"

    else
      @certification.approved_flag = true
      @certification.approved_by = current_candidate.first_name + " " + 
                              current_candidate.middle_name + " " + 
                              current_candidate.first_last_name + " " + 
                              current_candidate.second_last_name
      @certification.save
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s, '/certifications')
  end

  def action
    @certifications = Certification.all

    if(params[:update_button] != nil)
      @certifications.each do |row|
        @certification = params["approved_flag_" + row.id.to_s]
        row.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name

        if(@certification == nil)
          Certification.update(row.id, 
                          :approved_flag => false,
                          :approved_by => '')
        else
          Certification.update(row.id, 
                          :approved_flag => true,
                          :approved_by => row.approved_by)
        end
      end
    else
      
      if(params[:delete_button] != nil)

        for param in params
          if(param[0].include?"approved_flag_")
            if(param[0].index("approved_flag_") >= 0)
              certification = Certification.find(param[1])
              if (certification.used)
                flash[:notice] = "The Certification #{certification.name} is assigned can not be deleted."
              else
                Certification.delete(certification.id)
              end
            end
          end
        end
      end 
    end
      
      #@certifications.each do |row|
        #@certification = params["approved_flag_" + row.id.to_s()]

        #if(@certification != nil && !row.used)
          #Certification.delete(row.id)
        #else
          #flash[:notice] = "The Certification #{row.name} is assigned can not be deleted."
        #end
      #end
    #end

    redirect_to File.join('/staff/', current_candidate.id.to_s, '/certifications')
  end
end
