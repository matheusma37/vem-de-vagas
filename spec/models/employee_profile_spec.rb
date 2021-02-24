require 'rails_helper'

RSpec.describe EmployeeProfile, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:company) }
end
