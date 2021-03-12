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
require 'rails_helper'

RSpec.describe EmployeeProfile, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:company) }
  it { should validate_presence_of(:role).on(:update) }
  it { should validate_presence_of(:employee_code).on(:update) }
end
