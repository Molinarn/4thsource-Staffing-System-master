class InterviewerUser < ActiveRecord::Base
  belongs_to :interviewer
  belongs_to :candidate

  has_many :candidates_interviews

  def name
    candidate.actual_name
  end
 
end
