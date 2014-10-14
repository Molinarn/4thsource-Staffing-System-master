class Resume < ActiveRecord::Base

  attr_accessible :candidate_id, 
  :created_at,
  :updated_at,
  :updated_by 

  belongs_to      :candidate

  has_many        :resume_details,  :foreign_key => "resume_id",
                       :dependent => :destroy   
  #has_many        :education
  has_many              :candidate_education,  :foreign_key => "id",
   									   :dependent => :destroy 
  has_many        :projects,  :foreign_key => "resume_id",
									     :dependent => :destroy 
  has_many        :languages,  :foreign_key => "id",
  									   :dependent => :destroy 
end