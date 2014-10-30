class Interviewer < ActiveRecord::Base
  has_many :interviewer_users

  has_many :candidates, :through => :interviewer_users

  belongs_to :interviews_type

  attr_accessor :interviews_type_id
  
  attr_accessible :id,
                  :name,
                  :updated_by,
                  :interviews_type_id
                  
                  
  validates :name,               :presence => true
  validates :interviews_type_id, :presence => true

#  validates :interviews_type_id, :presence => true

  def used?
    !InterviewerUser.joins(:candidates_interviews).where(:interviewer_users => {:interviewer_id => id}).empty?
  end
  
end
