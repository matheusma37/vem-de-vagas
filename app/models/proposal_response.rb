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
class ProposalResponse < ApplicationRecord
  belongs_to :job_application

  validates :message, :salary_proposal, :start_date, presence: true
  validate :start_date_cannot_be_earlier_than_the_current_date

  private

  def start_date_cannot_be_earlier_than_the_current_date
    errors.add(:start_date, 'deve ser uma data no futuro') if start_date.present? && start_date < Date.today
  end
end
