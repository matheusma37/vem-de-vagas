# == Schema Information
#
# Table name: proposal_responses
#
#  id                 :integer          not null, primary key
#  message            :text             not null
#  salary_proposal    :float            not null
#  start_date         :date             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  job_application_id :integer          not null
#
# Indexes
#
#  index_proposal_responses_on_job_application_id  (job_application_id)
#
# Foreign Keys
#
#  job_application_id  (job_application_id => job_applications.id)
#
require 'rails_helper'

RSpec.describe ProposalResponse, type: :model do
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:salary_proposal) }
  it { should validate_presence_of(:start_date) }
  it { should belong_to(:job_application) }
  it { should allow_value(Date.today).for(:start_date) }
  it { should allow_value(Date.today.advance(days: 1)).for(:start_date) }
  it { should allow_value(Date.today.advance(months: 1)).for(:start_date) }
  it { should_not allow_value(Date.today.ago(1.day)).for(:start_date) }
  it { should_not allow_value(Date.today.ago(1.month)).for(:start_date) }
end
