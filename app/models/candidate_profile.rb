# == Schema Information
#
# Table name: candidate_profiles
#
#  id               :integer          not null, primary key
#  biography        :text
#  cellphone_number :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_candidate_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
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
