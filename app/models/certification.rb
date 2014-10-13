class Certification < ActiveRecord::Base
  belongs_to :resume_certification

  attr_accessible :id,
  :name,
  :description,
  :approved_flag,
  :approved_by

  validate :name, :allow_blank => false
  
  def used
    (CandidateCertification.where("certification_id = ?", id).length > 0)
  end
  
end
