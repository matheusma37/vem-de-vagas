class JobOpportunity < ApplicationRecord
  after_find :updates_status

  belongs_to :company
  has_many :job_applications
  has_many :candidate_profiles, through: :job_applications, source: :candidate_profile
  has_many :candidates, through: :candidate_profiles, source: :user

  enum professional_level: { junior: 3, pleno: 6, senior: 9 }
  enum status: { enable: 3, disable: 6 }

  validates :title, presence: true
  validates :max_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :min_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :professional_level, presence: true
  validates :total_job_opportunities, presence: true
  validates :status, presence: true

  def job_application_for(user)
    job_applications.find_by(candidate_profile: user.candidate_profile)
  end

  private

  def updates_status
    disable! if enable? && (!application_deadline.nil? && application_deadline < Date.today)
  end
end
