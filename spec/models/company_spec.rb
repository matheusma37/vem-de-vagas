require 'rails_helper'

RSpec.describe Company, type: :model do
  subject do
    User.create!(full_name: 'João', username: 'jojo',
                 email: 'jojo123@codante.com.br', password: '123456',
                 cpf: '01234567890',
                 about_me: 'Admin raivoso, gótico e trevoso.')
    Company.last
  end
  it { should validate_uniqueness_of(:email_domain).case_insensitive }
end
