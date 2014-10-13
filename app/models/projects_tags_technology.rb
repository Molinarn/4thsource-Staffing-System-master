class ProjectsTagsTechnology < ActiveRecord::Base
  self.per_page = 10
  
  belongs_to :projects_roles
  belongs_to :technology, :class_name => 'Technology', :foreign_key => :tech_id
  
end