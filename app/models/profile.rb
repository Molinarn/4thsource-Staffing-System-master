class Profile < ActiveRecord::Base
  # attr_accessible :title, :body

  self.per_page = 10

  attr_accessible :name, :description, :approved_flag, :approved_by
  
  belongs_to :candidate_profile
  
  validates :name,      presence: true
  
  validates :description,   		presence: true

  #validates :approved_flag,       	presence: true
  
  #validates :approved_by,       	presence: true

end
