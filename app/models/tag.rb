class Tag < ActiveRecord::Base
  attr_accessible :id,
                  :description, 
                  :name, 
                  :type_tag
                  :projects_tag_id

  #has_many :projects_tag, :dependent => :destroy
  belongs_to :projects_tag, :foreign_key => "projects_tag_id"

  has_many :requirements
  has_many :jobs, :through => :requirements
  has_many :jobs, :through => :job_matchs
  has_many :candidates_profile, :through => :r_candidate_tag

  validate :projects_tag_id, :presence => true
  #validate :name, :presence => true
  validate :type_tag, :presence => true
  #validate :description, :presence => true

  def used
    (ProjectsTag.where("tags_id = ?", id).length > 0)  
  end

  def technologies
	@names = ""  	
  	if type_tag == 3
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
