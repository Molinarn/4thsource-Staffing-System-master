class Tag < ActiveRecord::Base
  attr_accessible :id,
                  :description, 
                  :name, 
                  :type_tag,
                  :projects_tag_id,
                  :date_in,
                  :date_out

  validate :validate_end_date_before_start_date

  #has_many :projects_tag, :dependent => :destroy
  belongs_to :projects_tag, :foreign_key => "projects_tag_id"

  has_many :requirements
  has_many :jobs, :through => :requirements
  has_many :jobs, :through => :job_matchs
  has_many :candidates_profile, :through => :r_candidate_tag

  #validate :projects_tag_id, :presence => true
  #validate :name, :presence => true
  validate :type_tag, :presence => true
  #validate :description, :presence => true

  validates :date_in,       :presence => true

  validates :date_out,     :presence => true

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

  def validate_end_date_before_start_date
    return if date_out.nil?
    if date_out && date_in
      errors.add(:date_in, ": could not be after than Date out") if date_out < date_in
    end
  end
  
end
