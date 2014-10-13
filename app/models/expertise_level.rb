class ExpertiseLevel < ActiveRecord::Base
  attr_accessible :name

  #belongs_to :candidate
  
  validates :name,         :presence => true
end
