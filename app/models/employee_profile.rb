class EmployeeProfile < ApplicationRecord
  belongs_to :user
  belongs_to :company

  def admin?
    company&.admin == user
  end
end
