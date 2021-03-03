class JobApplication < ApplicationRecord
  belongs_to :candidate_profile
  belongs_to :job_opportunity

  enum status: { sended: 3, saw: 6, responded: 9, ended: 12, closed: 15 }
end
