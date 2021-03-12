# == Schema Information
#
# Table name: job_opportunities
#
#  id                      :integer          not null, primary key
#  application_deadline    :date
#  description             :text
#  max_salary              :float            default(0.0), not null
#  min_salary              :float            default(0.0), not null
#  professional_level      :integer          default("junior"), not null
#  status                  :integer          default("enable"), not null
#  title                   :string           not null
#  total_job_opportunities :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  company_id              :integer          not null
#
# Indexes
#
#  index_job_opportunities_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
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
  it { should have_many(:job_applications) }
  it { should have_many(:candidate_profiles).through(:job_applications) }
  it { should have_many(:candidates).through(:candidate_profiles) }
end
