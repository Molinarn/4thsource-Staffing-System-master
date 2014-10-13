class CandidateCertification < ActiveRecord::Base
  attr_accessible :certification_id,
   		:candidate_id
   		
  belongs_to :candidate
  belongs_to :certification
end
