# == Schema Information
#
# Table name: job_opportunities
#
#  id                      :integer          not null, primary key
#  application_deadline    :date
#  description             :text
#  max_salary              :float            default(0.0), not null
#  min_salary              :float            default(0.0), not null
#  professional_level      :integer          default("junior"), not null
#  status                  :integer          default("enable"), not null
#  title                   :string           not null
#  total_job_opportunities :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  company_id              :integer          not null
#
# Indexes
#
#  index_job_opportunities_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
FactoryBot.define do
  factory :opportunity_programmer, class: JobOpportunity do
    title { 'Programador' }
    max_salary { 3000.00 }
    min_salary { 1000.00 }
    professional_level { :junior }
    total_job_opportunities { 4 }
    status { :enable }
    company { Company.last }
  end

  factory :opportunity_analyst, class: JobOpportunity do
    title { 'Analista' }
    max_salary { 4000.00 }
    min_salary { 2500.00 }
    professional_level { :pleno }
    total_job_opportunities { 2 }
    status { :disable }
    description { 'Analisar projetos' }
    company { Company.last }
  end

  factory :opportunity_manager, class: JobOpportunity do
    title { 'Gerente de projetos' }
    max_salary { 8000.00 }
    min_salary { 5000.00 }
    professional_level { :senior }
    total_job_opportunities { 1 }
    status { :enable }
    company { Company.last }
    application_deadline { 10.days.ago }
  end
end
