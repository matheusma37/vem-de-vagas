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
class RefusalResponse < ApplicationRecord
  belongs_to :job_application

  enum refuser: { company: 3, candidate: 6 }
  validates :reason, presence: true
end
