class ExperienceDetail < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :experience
  
  validates :content,       :presence => true
  validates :experience_id, :presence => true
end
