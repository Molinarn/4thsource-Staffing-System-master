class ProjectsTag < ActiveRecord::Base
  self.per_page = 10
  #validate :validate_end_date_before_start_date

  #attr_accessible :date_in, :date_out, :description, :tags_id, :projects_role_id
  attr_accessible :description, :projects_role_id
  #attr_accessible :date_in, :date_out, :description, :projects_role_id

  belongs_to :projects_role
  #belongs_to :projectsRole

  #belongs_to :tags, :class_name => 'Tag', :foreign_key => :tags_id
  has_many :tags, :dependent => :destroy

  validate :projects_role_id, :presence => true

  #validates :tags_id,       :presence => true
  
  #validates :description,   :presence => true

  #validates :date_in,       :presence => true

  #validates :date_out,     :presence => true
  
  def validate_end_date_before_start_date
    return if date_out.nil? 
    if date_out && date_in
      errors.add(:date_in, ": could not be after than Date out") if date_out < date_in
    end
  end

end
