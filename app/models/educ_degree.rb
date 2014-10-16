class EducDegree < ActiveRecord::Base
  attr_accessible :id,
                  :name,
                  :description,
                  :approved_flag,
                  :approved_by

  belongs_to :candidate_education
  
  validates :name, :presence => true
  
  def used
    (CandidateEducation.where("educ_degree_id = ?", id).length > 0)  
  end
  
end
