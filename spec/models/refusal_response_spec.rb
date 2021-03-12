# == Schema Information
#
# Table name: refusal_responses
#
#  id                 :integer          not null, primary key
#  reason             :text
#  refuser            :integer          default("company")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  job_application_id :integer          not null
#
# Indexes
#
#  index_refusal_responses_on_job_application_id  (job_application_id)
#
# Foreign Keys
#
#  job_application_id  (job_application_id => job_applications.id)
#
require 'rails_helper'

RSpec.describe RefusalResponse, type: :model do
  it { should define_enum_for(:refuser) }
  it { should validate_presence_of(:reason) }
  it { should belong_to(:job_application) }
end
