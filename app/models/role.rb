class Role < ActiveRecord::Base
  attr_accessible :id, :approved_by, :approved_flag, :description, :name

  belongs_to :projects_role #:foreign_key => "role_id"

  #has_many :projects_roles
  #has_many :projects, :through => :projects_roles
  
  def used
    (ProjectsRole.where("role_id = ?", id).length > 0)  
  end
  
end
