class InterviewsQuestion < ActiveRecord::Base
  belongs_to :interviews_type
  attr_accessible :question
end
