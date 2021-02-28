require 'rails_helper'

RSpec.describe EmployeeProfile, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:company) }
  it { should validate_presence_of(:role).on(:update) }
  it { should validate_presence_of(:employee_code).on(:update) }
end
