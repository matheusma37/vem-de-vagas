FactoryBot.define do
  factory :user_admin, class: User do
    full_name { 'João da Silva Santos' }
    username { 'jojo' }
    email { 'jojo123@codante.com.br' }
    password { '123456' }
    password_confirmation { '123456' }
    cpf { Faker::Number.unique.number(digits: 11) }
    about_me { 'Admin raivoso, gótico e trevoso.' }
  end

  factory :user_employee, class: User do
    full_name { 'Severino Meik Duiff' }
    username { 'sefer0102' }
    email { 'sefer0102@codante.com.br' }
    password { '123456' }
    password_confirmation { '123456' }
    cpf { '12345678910' }
    about_me { 'Pau pra toda obra.' }
  end
end
