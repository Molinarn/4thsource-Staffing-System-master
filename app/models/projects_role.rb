
class ProjectsRole < ActiveRecord::Base

  self.per_page = 10
  validate :validate_end_date_before_start_date

  attr_accessible :id, :date_in, :date_out, :project_id, :role_id

  #added

  belongs_to    :project, :foreign_key => "project_id"

  #accepts_nested_attributes_for :project

  #belongs_to   :candidate

  #This was the original statement
  #belongs_to   :role, :class_name => 'Role', :foreign_key => :role_id

  #added

  #belongs_to    :role,  :foreign_key => :role_id

  has_one      :role, :as => :task, :foreign_key => :role_id
  #has_many    :roles

  #accepts_nested_attributes_for :roles

  #has_one     :project

  has_many     :projects_tags
  has_many     :roles_responsibilities
  has_many     :projects_tags_technologies, :foreign_key => :project_tag_id

  
  validates :project_id, :presence => true
  
  #validates :role_id,    :presence => true

  # validates :date_in,    :presence => true
  
  #validates :date_out,   :presence => true
  
  def tags1
    return projects_tags.where("tags_id in (select id from tags where type_tag=?)",1)
  end
  
  def tags2
    return projects_tags.where("tags_id in (select id from tags where type_tag=?)",2)
  end
  
  def tags3
    return projects_tags.where("tags_id in (select id from tags where type_tag=?)",3)
  end

  def technames(platform_id)
    @name = ""
    projects_tags_technologies.each do |p|
      if p.technology != nil
        if p.technology.lang_id == platform_id
          if @name == ""
            @name = p.technology.technology
          else
            @name = @name + ", " + p.technology.technology
          end
        end
      else
          if @name == ""
            @name = "---"
          else
            @name = @name + ", " + "---"
          end
      end
    end   
    if @name == ""
      @name = "- - -"
    end
    return @name 
  end
  
  def validate_end_date_before_start_date
    return if date_out.nil? 
    if date_out && date_in
      errors.add(:date_in, ": could not be after than Date out") if date_out < date_in
    end
  end
  
end
