class CandidateContactSource < ActiveRecord::Base
  attr_accessible :source

  belongs_to :candidate
  
  validates :source,         :presence => true
end
