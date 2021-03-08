class ProposalResponse < ApplicationRecord
  belongs_to :job_application

  validates :message, :salary_proposal, :start_date, presence: true
  validate :start_date_cannot_be_earlier_than_the_current_date

  private

  def start_date_cannot_be_earlier_than_the_current_date
    errors.add(:start_date, 'deve ser uma data no futuro') if start_date.present? && start_date < Date.today
  end
end
