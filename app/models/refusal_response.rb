class RefusalResponse < ApplicationRecord
  belongs_to :job_application

  enum refuser: { company: 3, candidate: 6 }
  validates :reason, presence: true
end
