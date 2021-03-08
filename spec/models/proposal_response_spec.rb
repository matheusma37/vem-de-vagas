require 'rails_helper'

RSpec.describe ProposalResponse, type: :model do
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:salary_proposal) }
  it { should validate_presence_of(:start_date) }
  it { should belong_to(:job_application) }
  it { should allow_value(Date.today).for(:start_date) }
  it { should allow_value(Date.today.advance(days: 1)).for(:start_date) }
  it { should allow_value(Date.today.advance(months: 1)).for(:start_date) }
  it { should_not allow_value(1.day.ago).for(:start_date) }
  it { should_not allow_value(1.month.ago).for(:start_date) }
end
