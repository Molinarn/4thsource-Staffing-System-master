
class TagsController < ApplicationController
  def index

    puts "\ntags#index".green

    @tags = Tag.paginate(:page => params[:page], 
                         :per_page => 20)

    set_wall_candidate(nil)
    set_my_wall(nil)
  end

  def new
    puts "\ntags#new".green
  end

  def technologies

    puts "\ntags#index".green

    #@languageId = params[:tech]
    #@tags = Technology.where('lang_id = ?', params[:tech])
    
    @tags = Tag.where('type_tag = ?', 3)
    
  end

  def technologies_delete 
    #@t = Technology.find(params[:technologyId])   
    @t = Tag.find(params[:technologyId])
    if @t.delete
      render :text => 'OK'
    else
      render :text => 'ERROR'
    end
  end

  def technologies_process
    
    puts "\ntags#technologies_process".green
    
    @rowId = params[:rowId]
    if  @rowId.to_i != -1
      @temp = Technology.new(params[:technology])      
      @t = Technology.find(params[:tech])
      if @t.update_attributes(params[:technology])
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                      "<a href='#!' onclick=\"Edit(#{@rowId},\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                      "X*M*" +
                      "<div style='text-align: center'><a href='#!' onclick=\"Delete(#{@rowId});\">x</a></div>"        
      else
        render :text => 'ERROR*Error while saving'
      end
    else    
      #@t = Technology.new(params[:technology])  
      
      params[:technology].each do |p|
        puts "#{p}".cyan
      end
          
      @t = Tag.new(:name => params[:technology][:name], :description => params[:technology][:description], :type_tag => 3, :date_in => DateTime.now, :date_out =>DateTime.now)
      if @t.save      
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                    "<a href='#!' onclick=\"Edit(#ROWID#,\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                    "X*M*" +
                    "<div style='text-align: center'><a href='#!' onclick=\"Delete(#ROWID#);\">x</a></div>"        
      else
        render :text => 'ERROR*Error while saving'
      end
    end
  end  

  def languages
    @tags = Tag.where('type_tag = ?', 3)
  end

  def languages_delete
    @t = Tag.find(params[:languageId])
    if @t.delete
      render :text => 'OK'
    else
      render :text => 'ERROR'
    end
  end

  def languages_process
    @rowId = params[:rowId]
    if @rowId.to_i != -1
      @temp = Tag.new(params[:language])
      @t = Tag.find(@temp.id)
      if @t.update_attributes(params[:language])
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                      "<a href='#!' onclick=\"Edit(#{@rowId},\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                      @t.description + "*M*<a href=languages/#{@t.id}/tech>View</a>*M*" +
                      "<div style='text-align: center'><a href='#!' onclick=\"Delete(#{@rowId});\">x</a></div>"        
      end
    else    
      @t = Tag.new(params[:language])
      @t.type_tag = 3
      if @t.save      
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                    "<a href='#!' onclick=\"Edit(#ROWID#,\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                    @t.description + "*M*<a href=languages/#{@t.id}/tech>View</a>*M*" +
                    "<div style='text-align: center'><a href='#!' onclick=\"Delete(#ROWID#);\">x</a></div>"        
      else
        render :text => 'ERROR*Error while saving'
      end
    end
  end  

  def tools
    @tags = Tag.where('type_tag = ?', 1)
  end

  def tools_delete
    @t = Tag.find(params[:toolId])
    if @t.delete
      render :text => 'OK'
    else
      render :text => 'ERROR'
    end
  end

  def tools_process
    
    puts "\ntags#tools_process".green
    
    @rowId = params[:rowId]
    if @rowId.to_i != -1
      @temp = Tag.new(params[:tool])
      @t = Tag.find(@temp.id)
      if @t.update_attributes(params[:tool])
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                      "<a href='#!' onclick=\"Edit(#{@rowId},\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                      @t.description + "*M*" +
                      "<div style='text-align: center'><a href='#!' onclick=\"Delete(#{@rowId});\">x</a></div>"        
      end
    else    
      #@t = Tag.new(params[:tool])
      @t = Tag.new(:name => params[:tool][:name], :description => params[:tool][:description], :type_tag => 1, :date_in => DateTime.now, :date_out =>DateTime.now)
      @t.type_tag = 1
      if @t.save      
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                    "<a href='#!' onclick=\"Edit(#ROWID#,\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                    @t.description + "*M*" +
                    "<div style='text-align: center'><a href='#!' onclick=\"Delete(#ROWID#);\">x</a></div>"        
      else
        render :text => 'ERROR*Error while saving'
      end
    end
  end

  def knowledges
    
    puts "\ntags#knowledges".green
    
    @tags = Tag.where('type_tag = ?', 2)
    
  end

  def knowledges_delete
    @t = Tag.find(params[:knowledgeId])
    if @t.delete
      render :text => 'OK'
    else
      render :text => 'ERROR'
    end
  end

  def knowledges_process   
    
    puts "\ntags#knowledge_process".green
     
    params.each do |p|
      puts "#{p}".cyan
    end 
     
    @rowId = params[:rowId]
    if @rowId.to_i != -1
      @temp = Tag.new(params[:knowledge])
      @t = Tag.find(@temp.id)
      if @t.update_attributes(params[:knowledge])
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                      "<a href='#!' onclick=\"Edit(#{@rowId},\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                      @t.description + "*M*" +
                      "<div style='text-align: center'><a href='#!' onclick=\"Delete(#{@rowId});\">x</a></div>"        
      end
    else    
      
      params[:knowledge].each do |pk|
        puts "#{pk}".magenta
      end
      
      @t = Tag.new(:name => params[:knowledge][:name], :description => params[:knowledge][:description], :type_tag => 2, :date_in => DateTime.now, :date_out =>DateTime.now)
      #@t.type_tag = 2
      if @t.save      
        render :text => "OK*M*#{@t.id.to_s}*M*" +
                    "<a href='#!' onclick=\"Edit(#ROWID#,\'#{@t.name}\');\">#{@t.name}</a>*M*" +
                    @t.description + "*M*" +
                    "<div style='text-align: center'><a href='#!' onclick=\"Delete(#ROWID#);\">x</a></div>"        
      else
        render :text => 'ERROR*Error while saving'
      end
    end
  end

  def create

    puts "\ntags#create".green

    @tag = Tag.new(params[:tag])

    if@tag.name.strip == "" || @tag.type_tag.to_i == 0
      flash[:notice] = "The tag has empty elements"
    else
      @tag.save
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s, '/tags')
  end

  def edit

    puts "\ntags#edit".green

    @tag = Tag.new(:id => params[:id],
                   :name => params[:name],
                   :type_tag => params[:type_tag],
                   :description => params[:description])
  end

  def destroy
    
    puts "\ntags#destroy".green
    
    Tag.delete(params[:id])
    redirect_to File.join('/staff/', current_candidate.id.to_s, '/tags')
  end

  def action
    
    puts "\ntags#destroy".green
    
    @tag = Tag.new(params[:tag])

    if params[:update_button] != nil
      Tag.update(:id => @tag.id,
                 :name => @tag.name,
                 :description => @tag.description,
                 :type_tag => @tag.type_tag)
    else
      Tag.delete(@tag.id)
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s, '/tags')
  end
end
