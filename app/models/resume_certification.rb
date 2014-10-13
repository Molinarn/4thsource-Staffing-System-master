class ResumeCertification < ActiveRecord::Base
  belongs_to :resume
  belongs_to :certification

  attr_accessible :id,
  :certification_id,
  :resume_id,
  :year

  validates :id, :presence => true
  validates :year, :presence => true
end