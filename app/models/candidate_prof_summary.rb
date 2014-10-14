class CandidateProfSummary < ActiveRecord::Base

  attr_accessible :summary,:candidate_id
 
  belongs_to :candidate  

  validates :summary, :presence => true

end
