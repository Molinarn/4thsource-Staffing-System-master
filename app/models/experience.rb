class Experience < ActiveRecord::Base
  
  attr_accessible :company_name,
                  :description, 
                  :job_position,
                  :start_date,
                  :end_date 
  
  has_many :tools
  has_many :experience_details, :dependent => :destroy
  has_many :skills, :through => :tools

end
