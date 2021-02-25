require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.create!(full_name: 'João', username: 'jojo',
                 email: 'jojo123@codante.com.br', password: '123456',
                 cpf: '01234567890',
                 about_me: 'Admin raivoso, gótico e trevoso.')
  end

  it { expect(subject.employee?).to be true }
  it { expect(subject.admin?).to be true }
  it { should have_one_attached(:avatar) }
  it { should delegate_method(:company).to(:employee_profile) }
  it { should delegate_method(:admin?).to(:employee_profile) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_uniqueness_of(:cpf).case_insensitive }
  it { should allow_value('123.456.789-10').for(:cpf) }
  it { should allow_value('12345678910').for(:cpf) }
  it { should_not allow_value('123.456.789.10').for(:cpf) }
  it { should_not allow_value('123456789-10').for(:cpf) }
  it { is_expected.to have_one(:employee_profile) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('tes.t@email.com').for(:email) }
  it { should allow_value('tes.t@email.com.br').for(:email) }
  it { should_not allow_value('tes.t@email.com.br.br').for(:email) }
  it { should_not allow_value('tes.t@email.').for(:email) }
  it { should_not allow_value('tes.temail.com').for(:email) }
  it { should_not allow_value('@email.com').for(:email) }
end
