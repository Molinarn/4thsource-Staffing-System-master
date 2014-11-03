class JobsController < ApplicationController

	@trace = true

	def index

    puts "\njobs#index".green

		#logger.debug("FLASSSSSSH >>>#{flash.inspect}")
    set_my_wall(nil)
    set_wall_candidate(nil)
    @job = Job.all

	end

	def new

    puts "\njobs#new".green

		@platforms=Tag.where('type_tag=?',3)
		@knowledge=Tag.where('type_tag=?',2)
		@tools= Tag.where('type_tag=?',1)
		@technologies=Technology.all
    @candidate = Candidate.find(params[:id])

    if request.post?
      params.each do |p|
        puts "#{p}".cyan
      end

      params[:new_job].each do |p|
        puts "#{p}".magenta
      end

      puts "\n#{@candidate.admin_users}".blue

      @job = @candidate.admin_users.first.jobs.new(params[:new_job])

      if @job.save

        flash[:success] = "job was saved successfully."
        render 'jobs/new'

      else
        flash[:notice] = "An error occurred while the system save the job."
      end

    end
#		binding.pry

	end

	def show
	logger.debug("jobs_controller.show");
    @job  = Job.find(params[:job_id])
    @title = @job.title
    end

    def destroy
    logger.debug("jobs_controller.destroy");
    Job.find(params[:job_id]).destroy
    redirect_to request.referer
    end

	def create

    puts "\njobs#create".green

		logger.debug("PARAMS>>>>>#{params.inspect}")
		if request.post?
			admin_id=current_candidate.id
			if admin_id.nil?
				logger.debug("<<<NIL USER>>>")
				flash[:notice]="Invalid user."
				redirect_to File.join('/staff/',admin_id.to_s, '/jobs')
			else
				logger.debug("OK>>>>>>>>>>>>>>>>>>")
				@admin_user=AdminUsers.where('candidates_id=?',admin_id)
				logger.debug("USEEEEER>>>>>>>#{@user.inspect}")
				if not @admin_user.nil?
					logger.debug("USER OK>>>>>>>>>")
					@new_job = Job.new
					@new_job.title=params[:new_job][:title]
					@new_job.description=params[:new_job][:description]
					@new_job.tag_id=params[:platforms_req]
					@new_job.save  
					redirect_to File.join('/staff/',admin_id.to_s,'/jobs')
				else
					flash[:notice]="<<<INVALID USER>>>"
					redirect_to File.join('/staff/',admin_id.to_s,'/jobs')
				end
			end
		else
			flash[:notice]="INVALID REQUEST."
			redirect_to File.join('/staff/',current_candidate.id.to_s, '/jobs')
		end	
    end

  #This method will duplicate the job but in the field id_parent placed the id of the original job. (Parent job)
  # job_id   parent_id
  #    1        0 (There is no parent)
  #If i made a job from the jobId=1 this gonna be the result on the DB
  #    2        1 (Job_id del padre)
  def duplicate
          
        job = Job.find(params[:job_id].to_i)
  
        newJob = Job.new
        newJob.title = job.title
        newJob.description = job.description
        newJob.other_requirements = job.other_requirements
        newJob.admin_users_id = job.admin_users_id
        newJob.id_requester = job.id_requester
        newJob.id_status = job.id_status
        newJob.id_parent = job.id
        newJob.save
          
        redirect_to request.referer
  end  
    

  #This method will duplicate the job but in the field id_parent placed the id of the original job. (Parent job)
  # job_id   parent_id
  #    1        0 (There is no parent)
  #If i made a job from the jobId=1 this gonna be the result on the DB
  #    2        1 (Job_id del padre)
  def duplicate
  	
  	job = Job.find(params[:job_id].to_i)
  
  	newJob = Job.new
  	newJob.title = job.title
  	newJob.description = job.description
  	newJob.other_requirements = job.other_requirements
	  newJob.admin_user_id = job.admin_user_id
	  newJob.id_requester = job.id_requester
	  newJob.id_status = job.id_status
	  newJob.id_parent = job.id
	  newJob.save
  	
  	redirect_to request.referer
  end  

  #En este metodo recuperaremos primero TODOS los tags para hacer el pintado en el formulario.
  #Posteriormente les pondremos checked a aquellos cuyo tag_id corresponda al del input checkBox  
  def edit
  	@trace = true

  	#binding.pry
  	

  	@platforms=Tag.where('type_tag=?',3) 
  	@knowledge=Tag.where('type_tag=?',2)
  	@tools= Tag.where('type_tag=?',1)

    #TO-DO Buscar como eliminar esta linea, lo que quiero es traerme la tabla completa
    @allTags = Tag.where('type_tag!=?',0)
    #binding.pry
    @jobsTags = getTags()
    if(@trace)
        logger.debug "====Jobs " + @jobsTags.to_s
    end

      #binding.pry

    if request.post?
      @job = Job.find(params[:job_id])
      
      params[:job].each do |p|
        puts "#{p}".cyan
      end
      
      @job.update_attributes(params[:job])
      if @job.save
        flash[:notice] = "Job saved successfully."
        #redirect_to File.join('/staff/',admin_id.to_s(),'/jobs')
      else
        flash[:notice] = "An error occurred while the system save the job."
      end
    else
      @job = Job.find(params[:job_id])
      @error = @job.errors
    end
  end

end




#Este metodo recuperara un vector con aquellos ids que deberan ir checked en el formulario
def getTags()

  # Este array es un vector de vectores ej. [[4,"C#",false][7,"Java",false]]
  tags = Array.new 

  #Para restarle complejidad al haml y como NO funciona :checked="false or true" en los navegadores.
  #Decidi crear un array con unicamente los ids que son verdaderos, es decir, que se pintaran cono checked  
  tagsChecked = Array.new

  jobsMatchs = JobMatch.where('job_id=?',params[:job_id])

  @allTags.each do |tag|
  	aux = [tag.id, tag.name, "false"]
	tags.push aux
  end 

  jobsMatchs.each do |jobMatch| 
  	tags.each do |tag|
  			if(tag.index(jobMatch.tag_id) != nil)
  				if(@trace)
  					logger.debug "Cambiando valor a " + jobMatch.tag_id.to_s
  				end
  				tag.fill("true", 2, 1)
  			end
  	end 
  end

  tags.each do |tag|
	if(tag.index("true") != nil)
		#tagsChecked.push(tag(0))
	end
  end 

  if(@trace)
    logger.debug "tags.size: " + tags.size.to_s
    logger.debug "tags: " + tags.to_s
    logger.debug "tagsChecked: " + tags.to_s
  end

  return tagsChecked
end