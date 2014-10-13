class RolesResponsibility < ActiveRecord::Base
  self.per_page = 10

  attr_accessible :description, :projects_role_id
  
  belongs_to :projects_roles
  
  validates :projects_role_id,   presence: true
  
  validates :description,         presence: true

end
