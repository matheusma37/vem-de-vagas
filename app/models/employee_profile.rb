# == Schema Information
#
# Table name: employee_profiles
#
#  id            :integer          not null, primary key
#  employee_code :string
#  role          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_employee_profiles_on_company_id  (company_id)
#  index_employee_profiles_on_user_id     (user_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#  user_id     (user_id => users.id)
#
class EmployeeProfile < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :role, :employee_code, presence: true, on: :update

  def admin?
    company&.admin == user
  end
end
