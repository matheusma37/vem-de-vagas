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
require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  it { should belong_to(:candidate_profile) }
  it { should belong_to(:job_opportunity) }
  it { should define_enum_for(:status) }
end
