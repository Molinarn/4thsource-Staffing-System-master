class AdminUser < ActiveRecord::Base

  attr_accessible :candidate_id, :edited_by, :is_active, :lvl

  #self.class_name "AdminUser"
  #self.table_name "admin_users"

  #belongs_to         :candidate, class_name => 'Candidate'
  #belongs_to         :candidate
  #has_one            :candidate, :as => :applicant
  #belongs_to          :candidate, :as => :applicant

  belongs_to          :candidate

  #:polymorphic => true
  								   #:foreign_key => 'candidates_id',

  has_many :jobs

  validates :candidate_id, :presence => true

end
