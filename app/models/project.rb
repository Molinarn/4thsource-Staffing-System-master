class Project < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :id, :candidate_id, :name, :summary, :company_name

  #has_and_belongs_to_many         :candidates,
                                  #:foreign_key => "project_id"

  has_many                     :candidates, :as => :applicant #:dependent => :destroy
  #accepts_nested_attributes_for :candidates

  #belongs_to                  :candidate_project
  #has_many   :candidates
  
  #has_many       :projects_roles,    :dependent => :destroy
  has_many :projects_roles, :dependent => :destroy
  #has_many :roles, :through => :projects_roles

  #accepts_nested_attributes_for :projects_roles
  #has_many :roles, :through => :projects_roles
  
  #validates :candidate_id, presence: true
  validates :candidate_id, :presence => true
  
  #validates :company_name,  :presence => true,
  #                          :length   => { :maximum => 255 }

  validates :name,          :presence => true,
                            :length   => { :maximum => 255 }
  
  validates :summary,       :presence => true,
                            :length   => { :maximum => 255 }

end