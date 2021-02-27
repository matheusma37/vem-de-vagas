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
