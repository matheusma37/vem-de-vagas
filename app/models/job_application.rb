class JobApplication < ApplicationRecord
  belongs_to :candidate_profile
  belongs_to :job_opportunity
end
