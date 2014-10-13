class RCandidateTag < ActiveRecord::Base
  attr_accessible :candidates_profile_id, :tag_id
  belongs_to :candidates_profile
  belongs_to :tag
end
