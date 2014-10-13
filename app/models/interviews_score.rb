class InterviewsScore < ActiveRecord::Base
  belongs_to :candidates_interview
  attr_accessible :score, :question
end
