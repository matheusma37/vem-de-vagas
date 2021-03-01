require 'rails_helper'

RSpec.describe CandidateProfile, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:biography).on(:update) }
  it { should allow_value('00 999999999').for(:cellphone_number).on(:update) }
  it { should allow_value('00999999999').for(:cellphone_number).on(:update) }
  it { should allow_value('00 99999999').for(:cellphone_number).on(:update) }
  it { should allow_value('0099999999').for(:cellphone_number).on(:update) }
  it { should_not allow_value('999999999').for(:cellphone_number).on(:update) }
  it { should_not allow_value('00 9999999').for(:cellphone_number).on(:update) }
  it { should_not allow_value('00 9999999').for(:cellphone_number).on(:update) }
  it { should_not allow_value('009999999').for(:cellphone_number).on(:update) }
end
