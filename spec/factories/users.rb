# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  about_me               :text
#  cpf                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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

  factory :user_candidate_gabriel, class: User do
    full_name { 'Gabriel Romero Jr.' }
    username { 'ga_rome' }
    email { 'garome73@example.com' }
    password { '123456' }
    password_confirmation { '123456' }
    cpf { '23456178910' }
    about_me { 'Amo pão e batatinhas.' }
  end

  factory :user_candidate_pedro, class: User do
    full_name { 'Pedro Oliveira Alves' }
    username { 'pedroca01' }
    email { 'pedroca01@example.com' }
    password { '123456' }
    password_confirmation { '123456' }
    cpf { '23561789104' }
    about_me { 'Maior leitor de prefácios que já existiu.' }
  end

  factory :user_candidate_paulo, class: User do
    full_name { 'Paulo da Silva Leite' }
    username { 'paulo_silva89' }
    email { 'paulo.silva89@example.com' }
    password { '123456' }
    password_confirmation { '123456' }
    cpf { '23456187910' }
    about_me { 'Sem legenda.' }
  end
end
