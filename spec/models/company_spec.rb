require 'rails_helper'

RSpec.describe Company, type: :model do
  subject do
    User.create!(full_name: 'João', username: 'jojo',
                 email: 'jojo123@codante.com.br', password: '123456',
                 cpf: '01234567890',
                 about_me: 'Admin raivoso, gótico e trevoso.')
    Company.last
  end
  it { should have_one_attached(:logo) }
  it { should have_one_attached(:cover) }
  it { should belong_to(:admin) }
  it { should validate_uniqueness_of(:email_domain).case_insensitive }
  it { should allow_value('email.com').for(:email_domain) }
  it { should allow_value('email.com.br').for(:email_domain) }
  it { should_not allow_value('email.com.br.br').for(:email_domain) }
  it { should_not allow_value('email.').for(:email_domain) }
  it { should_not allow_value('email').for(:email_domain) }
  it { should validate_uniqueness_of(:site) }
  it { should validate_uniqueness_of(:cnpj) }
end
