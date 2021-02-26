require 'rails_helper'

RSpec.describe JobOpportunity, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:max_salary).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:max_salary) }
  it { should validate_numericality_of(:min_salary) }
  it { should validate_presence_of(:min_salary) }
  it { should define_enum_for(:professional_level) }
  it { should validate_presence_of(:professional_level) }
  it { should validate_presence_of(:total_job_opportunities) }
  it { should define_enum_for(:status) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:company) }
end
