class ResumeDetail < ActiveRecord::Base
  belongs_to :resume;

  attr_accessible :summary
  
  validates :summary, :presence => true
end
