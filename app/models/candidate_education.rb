class CandidateEducation < ActiveRecord::Base
  attr_accessible :id,
                  :educ_degree_id,
                  :candidate_id,
                  :title,
                  :degree,
                  :date_in,
                  :date_out,
                  :university

  belongs_to :candidate
  has_many   :educ_degrees, :dependent => :destroy
  
  validates :candidate_id, :presence => true
  validates :title, :presence => true
end
