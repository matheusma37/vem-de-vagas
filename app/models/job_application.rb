# == Schema Information
#
# Table name: job_applications
#
#  id                   :integer          not null, primary key
#  status               :integer          default("sended")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  candidate_profile_id :integer          not null
#  job_opportunity_id   :integer          not null
#
# Indexes
#
#  index_job_applications_on_candidate_profile_id  (candidate_profile_id)
#  index_job_applications_on_job_opportunity_id    (job_opportunity_id)
#
# Foreign Keys
#
#  candidate_profile_id  (candidate_profile_id => candidate_profiles.id)
#  job_opportunity_id    (job_opportunity_id => job_opportunities.id)
#
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
