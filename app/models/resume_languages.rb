class ResumeLanguages < ActiveRecord::Base
  attr_accessible :name,
                  :level,
                  :resume_id
end