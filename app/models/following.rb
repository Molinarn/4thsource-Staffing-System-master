class Following < ActiveRecord::Base
  attr_accessible :followed_id
  
  validates :follower_id, :presence => true, :uniqueness => {:scope => :followed_id}
  validates :followed_id, :presence => true  
  
  belongs_to :follower, :class_name => "Candidate"
  belongs_to :followed, :class_name => "Candidate"
 
end
