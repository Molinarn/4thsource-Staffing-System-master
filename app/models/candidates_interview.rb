class CandidatesInterview < ActiveRecord::Base
  self.per_page = 10
  
  belongs_to :candidate

  belongs_to :interviewer_user

  belongs_to :interviews_type
  
  has_many :interviews_scores, :dependent => :delete_all

  accepts_nested_attributes_for :interviews_scores

  attr_accessible :candidate_id, :result, :interviewer_user_id, :interviews_type_id, :comments, :interviews_scores_attributes, :updated_at

  validates :candidate_id, :presence => true
  
  validates :interviewer_user_id, :presence=> true
  
  validates :interviews_type_id, :presence=> true

  def done?
    !result.blank?
  end
  
  def type
    interviews_type.name  
  end

end
