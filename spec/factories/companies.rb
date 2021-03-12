# == Schema Information
#
# Table name: companies
#
#  id            :integer          not null, primary key
#  address       :string
#  cnpj          :string
#  creation_date :date
#  description   :text
#  email_domain  :string           not null
#  name          :string
#  site          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_companies_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :company, class: Company do
    email_domain { 'codificante.com' }
    name { 'Codificante' }
    admin { association :user_employee }
    description { 'Empresa fazedora de código' }
    site { 'www.codan.te' }
    cnpj { '12.345.678/0009-10' }
    address { 'Rua ABC, Nº 01, Lugar Nenhum, Irineu - Neverland' }
    creation_date { 10.years.ago }
  end
end
