require 'rails_helper'

RSpec.describe CandidateProfile, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:cellphone_number).on(:update) }
  it { should validate_presence_of(:biography).on(:update) }
end
