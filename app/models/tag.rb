class Tag < ActiveRecord::Base
  attr_accessible :id,
                  :description, 
                  :name, 
                  :type_tag

  has_many :projects_tag, :dependent => :destroy

  has_many :requirements
  has_many :jobs, through: :requirements
  has_many :jobs, through: :job_matchs
  has_many :candidates_profile, through: :r_candidate_tag

  def used
    (ProjectsTag.where("tags_id = ?", id).length > 0)  
  end

  def technologies
	@names = ""  	
  	if (type_tag == 3)
  		@techs = Technologies.where("lang_id = ?", id)
		@techs.each do |t|
			if @names == ""
				@names = t.technology
			else
				@names = @names + ", " + t.technology
			end
		end  		
  	end
  	if @names == ""
  		@names = " - - - ";  		
  	end
  	return @names
  end
  
end
