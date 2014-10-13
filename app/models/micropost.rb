require 'ferret'
require 'acts_as_ferret'

class Micropost < ActiveRecord::Base
  #acts_as_ferret
  self.per_page = 5
  attr_accessible :content, :candidate_id, :created_by, :checked, :is_active, :created_at, :chain_id
  belongs_to :candidate

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :candidate_id, :presence => true
  validates :created_by, :presence => true

  #default_scope :order => "microposts.created_at DESC"

  def self.from_candidates_followed_by(candidate)
      followed_ids = candidate.following.map(&:id).join(", ")
      followed_ids = 0 if (followed_ids == nil || followed_ids.empty?)
      where("is_active = 1 AND (candidate_id = ? OR created_by = ?)", candidate.id, candidate.id)
      #binding.pry
  end

  def self.search_from_candidates_followed_by(candidate, words)
      if candidate.following.count > 0
        followed_ids = candidate.following.map(&:id).join(", ")
        followed_ids = 0 if (followed_ids == nil || followed_ids.empty?)
        followed_ids.concat(", " + candidate.id.to_s)
      else
        followed_ids = candidate.id.to_s
      end
      where("content LIKE ? AND is_active = 1 AND candidate_id IN (#{followed_ids})", "%#{words}%")
  end

end
