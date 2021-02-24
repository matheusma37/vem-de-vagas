require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_uniqueness_of(:cpf) }
  it { should allow_value('123.456.789-10').for(:cpf) }
  it { should allow_value('12345678910').for(:cpf) }
  it { should_not allow_value('123.456.789.10').for(:cpf) }
  it { should_not allow_value('123456789-10').for(:cpf) }
  it { is_expected.to have_one(:employee_profile) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should allow_value('tes.t@email.com').for(:email) }
  it { should allow_value('tes.t@email.com.br').for(:email) }
  it { should_not allow_value('tes.t@email.com.br.br').for(:email) }
  it { should_not allow_value('tes.t@email.').for(:email) }
  it { should_not allow_value('tes.temail.com').for(:email) }
  it { should_not allow_value('@email.com').for(:email) }
end
