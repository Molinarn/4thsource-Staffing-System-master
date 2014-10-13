class CandidateProfileTag < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :candidates_profile_id, :project_tags_id  
  
  #validates :candidate_profiles_id,      presence: true
  
  #validates :tags_id,   		presence: true

  #validates :projects_roles_id,       	presence: true

  belongs_to :candidate_profile
  belongs_to :projects_tag

end