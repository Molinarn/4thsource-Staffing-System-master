class CandidateProfSummary < ActiveRecord::Base

  attr_accessible :summary 
 
  belongs_to :candidate  

  validates :summary, :presence => true

end
