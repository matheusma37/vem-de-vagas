require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  it { should belong_to(:candidate_profile) }
  it { should belong_to(:job_opportunity) }
  it { should define_enum_for(:status) }
end
