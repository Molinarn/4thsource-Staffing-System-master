class EducDegree < ActiveRecord::Base
  attr_accessible :id,
                  :name,
                  :description,
                  :approved_flag,
                  :approved_by

  has_many :candidate_education, :dependent => :destroy
  
  validates :name, :presence => true
  
  def used
    (CandidateEducation.where("educ_degree_id = ?", id).length > 0)  
  end
  
end
