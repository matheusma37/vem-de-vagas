require 'rails_helper'

RSpec.describe RefusalResponse, type: :model do
  it { should define_enum_for(:refuser) }
  it { should validate_presence_of(:reason) }
end
