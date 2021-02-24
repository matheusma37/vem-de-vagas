require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { Company.create!(email_domain: 'codante.com.br') }
  it { should validate_uniqueness_of(:email_domain) }
end
