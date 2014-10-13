class CandidatesProfile < ActiveRecord::Base
  self.per_page = 10

#  attr_accessible :candidate_id, :name, :summary, :profile_data
attr_accessor :profile_data
attr_accessible :candidate_id, :name, :summary, :profiledata
  
  belongs_to :candidate
  has_many   :candidate_profile_tags, :dependent => :destroy 
  
  validates  :candidate_id, :presence => true
  validates  :name,   		  :presence => true
  validates  :summary,      :presence => true
  validates  :profiledata,  :presence => true

#  after_initialize          :associate_project
  
#  def associate_project
#    if new_record?
#      if self.profile
#    end
#  end

  
  
end