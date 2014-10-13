class ProjectsTag < ActiveRecord::Base
  self.per_page = 10
  validate :validate_end_date_before_start_date

  attr_accessible :date_in, :date_out, :description, :tags_id, :projects_role_id
  
  belongs_to :projects_roles
  belongs_to :tags, :class_name => 'Tag', :foreign_key => :tags_id
  
  validates :tags_id,       presence: true
  
  validates :description,   presence: true

  validates :date_in,       presence: true

  #validates :date_out,     presence: true
  
  def validate_end_date_before_start_date
    return if date_out.nil? 
    if date_out && date_in
      errors.add(:date_in, ": could not be after than Date out") if date_out < date_in
    end
  end

end
