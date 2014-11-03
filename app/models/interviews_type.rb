class InterviewsType < ActiveRecord::Base

  has_one :interviewer, :dependent => :destroy

  has_many :interviews_questions, :dependent => :delete_all

  has_many :interviewer_users , :through => :interviewer

  accepts_nested_attributes_for :interviews_questions

  attr_accessible :id, :name, :interviews_questions_attributes

  validates :name, :presence => true
  
  def used?
    !CandidatesInterview.where("interviews_type_id = ?", id).empty?  
  end
  
end
