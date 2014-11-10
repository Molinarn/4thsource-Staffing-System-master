class EducDegree < ActiveRecord::Base
  attr_accessible :id,
                  :name,
                  :description,
                  :approved_flag,
                  :approved_by
                  #:candidate_education_id

  #belongs_to :candidate_education
  #belongs_to :candidate_education
  #accepts_nested_attributes_for  :candidate_education

  validates :name, :presence => true
  
  def used
    #(CandidateEducation.where("educ_degree_id = ?", id).length > 0)  
    !self.candidate_education_id.nil?  
  end
  
end
