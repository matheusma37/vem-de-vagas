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
end
