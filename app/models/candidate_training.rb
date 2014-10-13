class CandidateTraining < ActiveRecord::Base
  attr_accessible :description, :name,:year
  belongs_to :candidate
  validates :name , :presence => true
end
