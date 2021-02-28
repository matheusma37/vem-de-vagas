class CandidateProfile < ApplicationRecord
  belongs_to :user

  validates :cellphone_number, :biography, presence: true, on: :update
end
