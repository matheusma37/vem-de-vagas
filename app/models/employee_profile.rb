class EmployeeProfile < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :role, :employee_code, presence: true, on: :update

  def admin?
    company&.admin == user
  end
end
