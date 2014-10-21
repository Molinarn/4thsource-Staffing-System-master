class RolesResponsibility < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :description, :role_id
  
  #belongs_to :projects_roles
  belongs_to :role, :dependent => :destroy, :foreign_key => "role_id"
  
  validates :role_id,   :presence => true
  
  validates :description,         :presence => true

end
