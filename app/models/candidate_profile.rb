class CandidateProfile < ApplicationRecord
  belongs_to :user
  has_many :job_applications
  has_many :job_opportunities, through: :job_applications

  validates :biography, presence: true, on: :update
  validates :cellphone_number, format: { with: /\A\d{2}\s?\d{8,9}\z/ }, on: :update

  def applied?(job_opportunity)
    job_opportunities.include?(job_opportunity)
  end
end
