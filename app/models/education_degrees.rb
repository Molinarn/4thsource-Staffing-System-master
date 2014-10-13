class EducationDegrees < ActiveRecord::Base
  belongs_to :resume_education

  attr_accessible :id,
  :name,
  :description,
  :approved_flag,
  :approved_by

  validates :id, :presence => true
  validates :name, :presence => true
  
end
