class CandidateProfile < ApplicationRecord
  belongs_to :user

  validates :biography, presence: true, on: :update
  validates :cellphone_number, format: { with: /\A\d{2}\s?\d{8,9}\z/ }, on: :update
end
