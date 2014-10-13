class CandidateProject < ActiveRecord::Base

  attr_accessible :candidate_id, :project_id

  has_many :candidates,  :foreign_key => :candidates_id
  has_many :projects,    :foreign_key => :projects_id

  def

end
