class Role < ActiveRecord::Base

  attr_accessible :id, :approved_by, :approved_flag, :description, :name, :projects_role_id

  #belongs_to :projects_role, :class_name => "ProjectsRole", :foreign_key => :role_id
  #belongs_to :projects_role, :foreign_key => :role_id

  #belongs_to :task, :polymorphic => true

  #belongs_to :projects_role, :foreign_key => :role_id

  #has_many    :projects_roles, :as => :projectRole, :foreign_key => "role_id" #, :inverse_of => :projects_roles

  belongs_to    :projects_role
  #has_many      :projects_roles, :as => :projectRole, :dependent => :destroy, :foreign_key => "role_id"
  has_many      :roles_responsibilities, :dependent => :destroy

  #has_one :projects_role, :foreign_key => :role_id
  #accepts_nested_attributes_for :projects_role

  #has_many :projects_roles
  #has_many :projects, :through => :projects_roles
  
  def used

    puts "\n role#used".red

    (ProjectsRole.where("role_id = ?", id).length > 0)  
  end
  
end
