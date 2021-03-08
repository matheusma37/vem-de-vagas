class JobApplication < ApplicationRecord
  belongs_to :candidate_profile
  belongs_to :job_opportunity

  has_one :refusal_response
  has_one :proposal_response

  enum status: { sended: 3, saw: 6, responded: 9, refused: 12, closed: 15 }

  def replied?
    %w[responded refused closed].include? status
  end
end
